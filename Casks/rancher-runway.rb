cask "rancher-runway" do
  version "1.2.4"
  sha256 "3336bcd559a21faebc01eadbf1840938357f5796dcb32dfa3efa92d857bb759b"

  url "https://github.com/brudnak/rancher-runway/releases/download/v1.2.4/Rancher-Runway-1.2.4-macOS-universal.dmg"
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
