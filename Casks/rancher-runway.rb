cask "rancher-runway" do
  version "1.3.0"
  sha256 "6545e1bba65d4551e728a0d445f7ac76f1bccf85e3392b386f8ab1d0fe9008c1"

  url "https://github.com/brudnak/rancher-runway/releases/download/v1.3.0/Rancher-Runway-1.3.0-macOS-universal.dmg"
  name "Rancher Runway"
  desc "Provision and validate disposable Rancher environments"
  homepage "https://github.com/brudnak/rancher-runway"

  depends_on macos: :monterey
  depends_on formula: ["hashicorp/tap/terraform", "helm", "kubernetes-cli", "gh"]

  app "Rancher Runway.app"

  zap trash: [
    "~/Library/Application Support/Rancher Runway",
    "~/Library/Caches/com.brudnak.rancher-runway",
    "~/Library/Preferences/com.brudnak.rancher-runway.plist",
    "~/Library/Saved Application State/com.brudnak.rancher-runway.savedState",
  ]
end
