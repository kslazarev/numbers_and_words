# Contributing

This project is work of [many contributors](https://github.com/kslazarev/numbers_and_words/graphs/contributors).

You're encouraged to submit [pull requests](https://github.com/kslazarev/numbers_and_words/pulls), [propose features and discuss issues](https://github.com/kslazarev/numbers_and_words/issues).

In the examples below, substitute your Github username for `contributor` in URLs.

### Fork the Project

Fork the [project on Github](https://github.com/kslazarev/numbers_and_words) and check out your copy.

```
git clone https://github.com/contributor/numbers_and_words.git
cd numbers_and_words
git remote add upstream https://github.com/kslazarev/numbers_and_words.git
```

### Bundle Install and Test

Ensure that you can build the project and run tests.

```
bundle install
bundle exec rake
```

CI runs tests, lint, and installed-package checks in separate workflows. Run `bundle exec rake spec` for tests or `bundle exec rake rubocop` for lint. Test jobs cover the supported Ruby 3.2 floor, current Ruby releases, JRuby, and macOS/Windows; Ruby head is experimental. Existing coverage reporting runs with the test suite.

Build the gem from `numbers_and_words.gemspec` and validate the actual archive in a temporary consumer with `bundle exec rake build` followed by `bundle exec ruby script/verify_package.rb`. The consumer installs the built gem and its runtime dependencies from RubyGems into a disposable directory, checks packaged source files, and exercises public APIs without the source checkout or development bundle.

Run `bundle exec rake benchmark` for throughput and allocation measurements; see [BENCHMARKS](BENCHMARKS.md) for workloads, controls, and comparison methodology.

Release automation, required setup, and safe local release tests are documented in [RELEASING](RELEASING.md). Release tooling requires CRuby 3.3+, independently of the Ruby 3.2 consumer minimum.

## Contribute Code

### Create a Topic Branch

Make sure your fork is up-to-date and create a topic branch for your feature or bug fix.

```
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

### Write Tests

Try to write a test that reproduces the problem you're trying to fix or describes a feature that you want to build. Add tests to [spec](spec).

We definitely appreciate pull requests that highlight or reproduce a problem, even without a fix.

#### Locale Character Validation

Locale specs validate decoded YAML strings against each locale's Unicode script, require NFC normalization, and reject invisible control/format characters. When adding a locale, register its script in `spec/numbers_and_words/i18n_spec.rb`. Accents, combining marks, punctuation, and spaces are allowed; English lookup identifiers in the Russian and Ukrainian `mega`/`micro` arrays are checked separately as Latin text. These checks do not replace spelling or translation review.

Run the character validation specs with `bundle exec rspec spec/locale_characters_spec.rb spec/numbers_and_words/i18n_spec.rb`, or run `bundle exec rake` for the full lint and test suite.

### Write Code

Implement your feature or bug fix.

Make sure that `bundle exec rake` completes without errors.

### Write Documentation

Document any external behavior in the [README](README.md) or the relevant [language page](docs/languages).

### Update Changelog

Add a line to [CHANGELOG](CHANGELOG.md) under *Next Release*. Don't remove *Your contribution here*.

Make it look like every other line, including a link to the issue being fixed, your name and link to your Github account.

### Commit Changes

Make sure git knows your name and email address:

```
git config --global user.name "Your Name"
git config --global user.email "contributor@example.com"
```

Writing good commit logs is important. A commit log should describe what changed and why.

```
git add ...
git commit
```

### Push

```
git push origin my-feature-branch
```

### Make a Pull Request

Go to https://github.com/contributor/numbers_and_words and select your feature branch. Click the 'Pull Request' button and fill out the form. Pull requests are usually reviewed within a few days.

### Update CHANGELOG Again

Update the [CHANGELOG](CHANGELOG.md) with the pull request number.

Amend your previous commit and force push the changes.

```
git commit --amend
git push origin my-feature-branch -f
```

### Rebase

If you've been working on a change for a while, rebase with upstream/master.

```
git fetch upstream
git rebase upstream/master
git push origin my-feature-branch -f
```

### Check on Your Pull Request

Go back to your pull request after a few minutes and see whether it passed muster with GitHub Actions. Everything should look green, otherwise fix issues and amend your commit as described above.

### Be Patient

It's likely that your change will not be merged and that the nitpicky maintainers will ask you to do more, or fix seemingly benign problems. Hang on there!

## Updating the Logo

The logo, [assets/logo.svg](assets/logo.svg), shows `42.to_words` returning `"forty-two"`: a red 42 tile speaks through a speech bubble. It was designed with Claude, an AI assistant, for this project. [script/logo.rb](script/logo.rb) is its editable source: [script/logo/layout.rb](script/logo/layout.rb) lays out the shapes, and the script converts the lettering, set in [IBM Plex Mono](https://github.com/IBM/plex) Medium and [Space Grotesk](https://github.com/floriankarsten/space-grotesk) Bold, to outlines so the SVG renders the same everywhere. It reads the fonts with the Ruby standard library only. Both fonts are licensed under the SIL Open Font License; the fonts themselves are not committed. To regenerate the logo, download the fonts and run the script.

```sh
fonts=$(mktemp -d)
curl -sSfL -o "$fonts"/IBMPlexMono-Medium.ttf https://raw.githubusercontent.com/google/fonts/main/ofl/ibmplexmono/IBMPlexMono-Medium.ttf
curl -sSfL -o "$fonts"/SpaceGrotesk-Bold.ttf https://raw.githubusercontent.com/floriankarsten/space-grotesk/master/fonts/ttf/static/SpaceGrotesk-Bold.ttf
ruby script/logo.rb "$fonts" assets/logo.svg
```

Check the result on light and dark backgrounds at full size and in the README, where it is displayed 160 pixels wide.

## Language Documentation

Each supported language has a page in [docs/languages](docs/languages) with examples and the options it supports, linked from the table in the [README](README.md). When you change a language's output or add an option, update its page; `spec/numbers_and_words/documentation_spec.rb` checks every example in the README and the language pages and fails when one no longer matches. Examples are parsed, never evaluated: write each as `I18n.with_locale(:en) { 21.to_words(ordinal: true) }` on one line, with a number or an array of numbers and options whose values are `true`, `false`, integers or symbols, followed by a `# => value` line with the inspected result. Any other `I18n.with_locale` line fails the spec. Every option a language accepts must appear in at least one example on its page, and every global option in the README (`spec/numbers_and_words/option_documentation_spec.rb`). To add a language, add a page and a row to the README table.

Native speakers are especially welcome to review the examples and report or fix anything that reads wrong. A language is marked experimental in the README while it has known gaps or no native-speaker review; its page explains why. Remove the mark, and the explanation, in the PR that closes the last gap.

## Contributors

* [Kirill Lazarev](https://github.com/kslazarev)
* [Daniel Doubrovkine](https://github.com/dblock)
* [Sergey Shkirando](https://github.com/Shk-Serji)
* [Ulrich Sossou](https://github.com/sorich87)
* [eLod](https://github.com/eLod)
* [Mārtiņš Spriņģis](https://github.com/martinsspringis)
* [Miks Miķelsons](https://github.com/miks)

See also [all contributors](https://github.com/kslazarev/numbers_and_words/graphs/contributors).

## Thank You

Please do know that we really appreciate and value your time and work. We love you, really.
