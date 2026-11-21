# Releasing

Releases use [ruby-gem-release](https://github.com/dblock/ruby-gem-release) 0.9.0, which builds the gem from `numbers_and_words.gemspec`. The gemspec reads its version from `lib/numbers_and_words/version.rb`, so preparing a release only updates that file and the changelog. Only a manual workflow dispatch publishes; merging a PR never does.

## One-Time Setup

- **GitHub environment:** a repository administrator creates an environment named `release`, restricted to `master`, with required maintainer reviewers. An unprotected environment doesn't limit who can publish.
- **RubyGems trusted publisher:** a gem owner configures the [trusted publisher](https://rubygems.org/gems/numbers_and_words/trusted_publishers) with repository owner `kslazarev`, repository `numbers_and_words`, workflow `release.yml`, environment `release`, reusable workflow owner `dblock` and repository `ruby-gem-release`. No API key is needed.
- **Branch protection:** the Actions token must be able to push the release commits and tags to `master` and create GitHub Releases. Use a narrow exception if needed; never allow force pushes or tag overwrites.

## Validation

Consumers support Ruby 3.2, but release tooling needs CRuby 3.3+ (ruby-gem-release and the native Commonmarker gem), so its specs are skipped on Ruby 3.2, JRuby, Windows and Ruby head. The workflow runs on Ruby 4.0. The reusable workflow is pinned to its release tag's commit; upgrade it together with the gem, following the [upstream notes](https://github.com/dblock/ruby-gem-release/blob/v0.9.0/UPGRADING.md).

Run `bundle exec rake`, then `bundle exec rake build` and `bundle exec ruby script/verify_package.rb`. The release spec prepares a release against disposable local Git remotes and a fake registry, without authenticating, publishing or pushing.

## Dry Run

`gh workflow run release.yml --repo kslazarev/numbers_and_words --ref master -f dry-run=true` checks the setup without releasing. It runs in the `release` environment, so reviewers approve it, exchanges an OIDC token with RubyGems, and checks that the release commit and tag can be pushed, without changing anything.

## Publish

Once a release is authorized, run `gh workflow run release.yml --repo kslazarev/numbers_and_words --ref master`, optionally with `-f version=1.2.3`; without it, the checked-in version is used.

The workflow prepares the version and changelog, tests the installed archive, publishes it through RubyGems trusted publishing, pushes the release commit and tag, and creates a GitHub Release. It then bumps the patch version and starts a new changelog section.

Never run `release:publish` as a preview. After publishing, check the registry, tag, GitHub Release and next development version. If a run fails after publishing, inspect what exists before retrying, and never overwrite a published version or move a tag; see the [upstream recovery guide](https://github.com/dblock/ruby-gem-release/blob/v0.9.0/RELEASING.md#verify-and-recover).
