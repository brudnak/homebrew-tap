cask "rancher-runway" do
  version "1.1.1"
  sha256 "9348483b2da3dc662f125cae1b001dd73f0be3827a546f49a5da54571cb628b4"

  url "https://github.com/brudnak/rancher-runway/releases/download/v1.1.1/Rancher-Runway-1.1.1-macOS-universal.dmg"
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
