# brudnak Homebrew Tap

Homebrew packages for [Rancher Runway](https://github.com/brudnak/rancher-runway).

The tap is prepared for its first release. Rancher Runway becomes installable
when a published stable release supplies `Casks/rancher-runway.rb` with the
real DMG URL and SHA-256 checksum. An empty tap cannot install the app.

## Install

Once the Cask is published:

```bash
brew tap hashicorp/tap
brew trust --formula hashicorp/tap/terraform
brew install --cask brudnak/tap/rancher-runway
```

The first two commands add HashiCorp's tap and trust its Terraform formula.
Homebrew requires explicit trust for this dependency; installing Rancher
Runway does not grant trust to Terraform automatically. See
[Homebrew's tap trust instructions](https://docs.brew.sh/Tap-Trust).

Homebrew adds the Rancher Runway tap automatically. The Cask installs the universal macOS
app and its Terraform, Helm 3, kubectl, and GitHub CLI (`gh`) dependencies.

For GitHub features such as Issue Radar, authenticate once in Terminal:

```bash
gh auth login
```

### First launch

Default Rancher Runway releases are ad-hoc signed and are not notarized by
Apple. No paid Apple Developer account is needed to publish these builds.
If macOS blocks the app because the developer cannot be verified or Apple
cannot check it for malicious software, and you trust the downloaded release:

1. Try opening Rancher Runway from Applications, then dismiss the alert.
2. Open **System Settings → Privacy & Security → Open Anyway**.
3. Confirm **Open** and authenticate if prompted.

Updates may require approval again. Managed Macs may restrict this option.
See [Apple's per-app approval instructions](https://support.apple.com/en-us/102445).
Developer ID signing and notarization can be enabled in the application's
release workflow later.

## Upgrade and uninstall

```bash
brew update
brew upgrade --cask rancher-runway
brew uninstall --cask rancher-runway
```

Upgrades and normal uninstallation preserve configuration, Terraform state,
kubeconfigs, logs, and run records under
`~/Library/Application Support/Rancher Runway`.

`brew uninstall --zap rancher-runway` removes that data. Destroy or account
for live infrastructure before using it.

## Populate and maintain the Cask

The app repository owns the Cask template and release artifacts. This tap
holds the rendered, checksum-pinned Cask; it does not build or notarize the app.

### Release from the application checkout

The application's release command handles versioning, publication, and the tap:

```bash
make release-plan
make release
```

Run these in the `rancher-runway` checkout after publishing the intended
application source to GitHub. The first version is `v1.0.0`; later runs bump
the patch version. Use `RELEASE_BUMP=minor` or `RELEASE_BUMP=major` for larger
changes. `RELEASE_VERSION=v1.0.0` selects or retries that exact version.

The command uses your authenticated `gh` CLI to create the release tag, wait
for the build, verify the downloaded DMG/Cask, and update this tap. It needs
Contents write access to both repositories and Actions write access to
`rancher-runway`. It does not need `HOMEBREW_TAP_TOKEN`. The tap update creates
a Cask commit on GitHub; the command does not commit application source or
update this local checkout.

### Updates when releasing directly from GitHub

In **brudnak/rancher-runway → Settings → Environments**, create the
`macos-release` environment and optionally add `HOMEBREW_TAP_TOKEN` as an
environment secret. Use a fine-grained token scoped to this repository with
**Contents: Read and write**.

Leave `RANCHER_RUNWAY_SIGNING_MODE` unset or set to `adhoc` in the app
repository. The release workflow defaults to:

| Setting | Value |
| --- | --- |
| `HOMEBREW_TAP_REPOSITORY` | `brudnak/homebrew-tap` |
| `HOMEBREW_CASK_PATH` | `Casks/rancher-runway.rb` |

Once the updated release workflow is available on GitHub, a successful stable
release publishes the DMG and generated Cask, then writes the Cask here when
the tap token is configured. Prereleases do not update the stable Cask. The
token must remain valid and repository rules must permit that file update.

### Import a published release locally

If automatic updates are not configured, use the helper from this checkout.
It requires Bash, the GitHub CLI (`gh`), Ruby, and `shasum`:

```bash
scripts/update-cask.sh v1.0.0
```

Replace `v1.0.0` with an existing published stable release tag. The helper
downloads its generated Cask and DMG from `brudnak/rancher-runway`, checks
Ruby syntax, the version and download URL, and the DMG's actual SHA-256, then
updates the local `Casks/rancher-runway.rb`. Failed validation leaves any
existing Cask unchanged. It does not publish files or make commits.

The local Cask must be made available in this repository's default branch
before other users can install it. Do not copy the upstream `.rb.tmpl` into
`Casks/`, invent a checksum, or use `sha256 :no_check`.

See the [application release guide](https://github.com/brudnak/rancher-runway/blob/main/docs/homebrew-release.md)
for building and publishing the first release.

## Validation

The check workflow validates the helper's shell syntax and each Cask's Ruby
syntax, checks for unrendered placeholders, and requires a SHA-256 pin. It
reports when no Casks have been published yet.

After publishing the first Cask, test installation and first launch on a Mac
without a source checkout. Test a later upgrade to confirm application data
is preserved. Syntax checks alone do not verify installation or launch.
