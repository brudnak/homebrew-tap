cask "rancher-runway" do
  version "1.3.1"
  sha256 "7fb8bbf3c2d6122f53f05d7b353c160729525035fca0402c68e5eb5914bcf9de"

  url "https://github.com/brudnak/rancher-runway/releases/download/v1.3.1/Rancher-Runway-1.3.1-macOS-universal.dmg"
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
