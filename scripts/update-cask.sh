#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/update-cask.sh <vMAJOR.MINOR.PATCH>

Download the generated Rancher Runway Cask and DMG from a published stable
release, verify the Cask's metadata and DMG checksum, and update the local
Casks/rancher-runway.rb. Does not publish files or make commits.

Requires: gh, ruby, shasum. The release must already exist on GitHub.
EOF
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi
if [[ $# -ne 1 || ! "$1" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  usage >&2
  exit 2
fi
for tool in gh ruby shasum; do
  command -v "$tool" >/dev/null 2>&1 || die "$tool is required"
done

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_repo="brudnak/rancher-runway"
release_tag="$1"
version="${release_tag#v}"
asset_name="Rancher-Runway-${version}-macOS-universal.dmg"
expected_url="https://github.com/${source_repo}/releases/download/${release_tag}/${asset_name}"

if ! publishable="$(gh release view "$release_tag" --repo "$source_repo" \
  --json isDraft,isPrerelease --jq '(.isDraft == false and .isPrerelease == false)')"; then
  die "release $release_tag is unavailable; publish the application release first"
fi
[[ "$publishable" == "true" ]] || die "only published stable releases may update this Cask"

temporary_root="$(mktemp -d "${TMPDIR:-/tmp}/runway-cask.XXXXXX")"
trap 'rm -rf "$temporary_root"' EXIT
gh release download "$release_tag" --repo "$source_repo" \
  --pattern rancher-runway.rb --pattern "$asset_name" --dir "$temporary_root"

cask="$temporary_root/rancher-runway.rb"
dmg="$temporary_root/$asset_name"
[[ -s "$cask" && -s "$dmg" ]] || die "release must contain a generated Cask and nonempty DMG"
checksum="$(shasum -a 256 "$dmg" | awk '{print $1}')"
ruby -c "$cask"
ruby - "$cask" "$version" "$checksum" "$expected_url" <<'RUBY'
path, version, checksum, url = ARGV
text = File.read(path)
abort "Unrendered Cask template" if text.match?(/@[A-Z_]+@/)
abort "Unexpected Cask name" unless text.lines.first&.strip == 'cask "rancher-runway" do'
checks = {
  "version" => [text.scan(/^[ \t]*version[ \t]+"([^"]+)"[ \t]*$/).flatten, version],
  "SHA-256" => [text.scan(/^[ \t]*sha256[ \t]+"([^"]+)"[ \t]*$/).flatten, checksum],
  "download URL" => [text.scan(/^[ \t]*url[ \t]+"([^"]+)"[ \t]*,?[ \t]*$/).flatten, url],
  "app bundle" => [text.scan(/^[ \t]*app[ \t]+"([^"]+)"[ \t]*$/).flatten, "Rancher Runway.app"],
}
checks.each do |label, (values, expected)|
  abort "Cask #{label} does not match the release artifact" unless values == [expected]
end
RUBY

mkdir -p "$repo_root/Casks"
install -m 0644 "$cask" "$repo_root/Casks/rancher-runway.rb"
printf 'Updated local Casks/rancher-runway.rb for %s (SHA-256 %s)\n' "$release_tag" "$checksum"
