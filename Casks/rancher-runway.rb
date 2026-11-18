cask "rancher-runway" do
  version "1.3.6"
  sha256 "577b9cf76c487cce0a366ccfae8a370d5eac1631d051bc3de2bb1013e9ba1256"

  url "https://github.com/brudnak/rancher-runway/releases/download/v1.3.6/Rancher-Runway-1.3.6-macOS-universal.dmg"
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
