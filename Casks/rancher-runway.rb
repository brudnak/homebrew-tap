cask "rancher-runway" do
  version "1.3.5"
  sha256 "065ed70ffcbc432912e76d837998361a2bcd309012f2609ea96aa3080aff9dd6"

  url "https://github.com/brudnak/rancher-runway/releases/download/v1.3.5/Rancher-Runway-1.3.5-macOS-universal.dmg"
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
