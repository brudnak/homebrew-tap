cask "rancher-runway" do
  version "1.3.2"
  sha256 "1d6d6f8aee5d01cac1390117ac951b4d99e634fa64c0492110c9a17b408ea4c4"

  url "https://github.com/brudnak/rancher-runway/releases/download/v1.3.2/Rancher-Runway-1.3.2-macOS-universal.dmg"
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
