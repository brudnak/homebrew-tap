cask "rancher-runway" do
  version "1.3.4"
  sha256 "ca6514b6d9a74c959310407eb5a3a04ede8d76b0d16156803e2c91bacd94b2a9"

  url "https://github.com/brudnak/rancher-runway/releases/download/v1.3.4/Rancher-Runway-1.3.4-macOS-universal.dmg"
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
