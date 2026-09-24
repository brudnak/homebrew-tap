cask "rancher-runway" do
  version "1.2.1"
  sha256 "1d7f1d9c9e990a821edc93624388c7547905da521639f2d85dc47e9de52940ae"

  url "https://github.com/brudnak/rancher-runway/releases/download/v1.2.1/Rancher-Runway-1.2.1-macOS-universal.dmg"
  name "Rancher Runway"
  desc "Provision and validate disposable Rancher environments"
  homepage "https://github.com/brudnak/rancher-runway"

  depends_on macos: :monterey
  depends_on formula: ["hashicorp/tap/terraform", "helm@3", "kubernetes-cli", "gh"]

  app "Rancher Runway.app"

  zap trash: [
    "~/Library/Application Support/Rancher Runway",
    "~/Library/Caches/com.brudnak.rancher-runway",
    "~/Library/Preferences/com.brudnak.rancher-runway.plist",
    "~/Library/Saved Application State/com.brudnak.rancher-runway.savedState",
  ]

  caveats <<~EOS
    Rancher Runway uses ad-hoc signing and is not notarized by Apple.
    Try opening the app after installation. If macOS blocks it because the
    developer cannot be verified or Apple cannot check it for malicious software,
    and you trust this download, open System Settings > Privacy & Security >
    Open Anyway, then confirm Open. Updates may require approval again.
    https://support.apple.com/en-us/102445
  EOS
end
