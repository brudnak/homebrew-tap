cask "rancher-runway" do
  version "1.3.3"
  sha256 "7c57412dee97f6724ba68ee7bde57b25401bc69831b2cec5c9591a33a6e6af8d"

  url "https://github.com/brudnak/rancher-runway/releases/download/v1.3.3/Rancher-Runway-1.3.3-macOS-universal.dmg"
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
