# Releasing

Releases use [ruby-gem-release](https://github.com/dblock/ruby-gem-release) 0.9.0, which builds the gem from the checked-in `numbers_and_words.gemspec`. The gemspec reads its version from `lib/numbers_and_words/version.rb`, so release preparation only updates the version file and changelog. Publication requires an explicit manual workflow dispatch; merging a PR does not publish. Adding this configuration does not authorize or perform a release.

## One-Time Setup

A repository administrator must create a GitHub environment named `release`, restrict it to `master`, and configure required maintainer reviewers as appropriate. Creating an unprotected environment does not limit who can publish.

A RubyGems owner must configure the existing [numbers_and_words trusted publisher](https://rubygems.org/gems/numbers_and_words/trusted_publishers): repository owner `kslazarev`, repository `numbers_and_words`, workflow filename `release.yml`, environment `release`, reusable workflow owner `dblock`, and reusable workflow repository `ruby-gem-release`. No long-lived RubyGems API key is needed. This is an existing gem, so no first-publication account ID is required.

The Actions token needs permission to push fast-forward release/development commits and new tags to `master`, and create GitHub Releases. Review branch protection before dispatch; configure a narrowly scoped release exception if required rather than weakening ordinary development rules. Never permit force pushes or tag overwrites. These administrative and registry changes must be separately authorized; they are not made by this PR.

## Validation

Consumers and ordinary tests retain Ruby 3.2 support. Release tooling requires CRuby 3.3+ and is omitted on Ruby 3.2 and JRuby: ruby-gem-release requires Ruby 3.3, and parsing this Markdown changelog requires the native Commonmarker gem. The workflow runs on Ruby 4.0. The reusable workflow is pinned to the commit of its release tag, with the tag in a trailing comment; upgrade the gem and that pin together, following [upstream upgrade notes](https://github.com/dblock/ruby-gem-release/blob/v0.9.0/UPGRADING.md).

Run `bundle exec rake`, then `bundle exec rake build` and `bundle exec ruby script/verify_package.rb`. The release spec uses the real gemspec and release configuration, disposable local Git remotes, and local registry/hosting adapters; it does not authenticate, publish, or push to GitHub. It covers explicit version selection, both changelog phases, exact archive publication, and empty-release rejection.

Release simulation runs on stable CRuby 3.3+ on Linux/macOS, matching the POSIX release runner. It is explicitly skipped on Windows because ruby-gem-release 0.9.0's fixture copies only `PATH`, omitting Windows' `Path` entry, and on development Ruby snapshots where default-gem activation can differ. Consumer conversion and installed-package checks still run on Windows; Ruby head remains experimental.

## Dry Run

After one-time setup, verify it without releasing with `gh workflow run release.yml --repo kslazarev/numbers_and_words --ref master -f dry-run=true`. The dry run runs in the `release` environment, so required reviewers still approve it. It exchanges an OIDC token with RubyGems exactly as publication would, checks that the token can push the release commit and tag past repository rules, and never edits files, pushes, builds, or publishes. Every real release runs the same checks before making changes.

## Publish

After explicit release authorization and confirmed setup, dispatch from `master` with `gh workflow run release.yml --repo kslazarev/numbers_and_words --ref master`. Optionally append `-f version=1.2.3` to select a version. An empty version input uses the checked-in version.

The workflow prepares the version and categorized changelog, tests prepared files and an installed archive, preserves recovery artifacts, publishes the verified gem through RubyGems Trusted Publishing, pushes its commit/tag, and creates a GitHub Release. Features or Bugs sections without notes are dropped from the release. It then increments the patch version, starts the next development section with Features and Bugs placeholders, and pushes the next-development commit. New release headings use `YYYY/MM/DD`; historical headings are preserved.

Never invoke `release:publish` as a preview. After publication, verify the registry version, immutable tag, GitHub Release and archive, and next-development version. If a run fails after publication, inspect existing state and retained recovery artifacts before retrying; never overwrite a published version or move a tag. Follow [upstream recovery guidance](https://github.com/dblock/ruby-gem-release/blob/v0.9.0/RELEASING.md#verify-and-recover).
