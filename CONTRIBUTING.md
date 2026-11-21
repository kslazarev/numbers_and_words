# Contributing

This project is the work of [many contributors](https://github.com/kslazarev/numbers_and_words/graphs/contributors).

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

Run `bundle exec rake spec` for tests only or `bundle exec rake rubocop` for lint only. CI runs tests on Ruby 3.2 and later, JRuby, macOS and Windows.

`bundle exec rake build` followed by `bundle exec ruby script/verify_package.rb` installs the built gem in a throwaway directory and exercises it there, without the source checkout.

See [BENCHMARKS](BENCHMARKS.md) for performance measurements and [RELEASING](RELEASING.md) for releases.

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

Locale strings must use the locale's script, be NFC-normalized, and contain no invisible characters. When adding a locale, register its script in `spec/numbers_and_words/i18n_spec.rb`. Run these checks with `bundle exec rspec spec/locale_characters_spec.rb spec/numbers_and_words/i18n_spec.rb`.

### Write Code

Implement your feature or bug fix.

Make sure that `bundle exec rake` completes without errors.

### Write Documentation

Document any external behavior in the [README](README.md) or the relevant [language page](docs/languages).

### Update Changelog

Add a line to [CHANGELOG](CHANGELOG.md) in the *(Next)* section, formatted like the others, with a link to your pull request and your GitHub account. Don't remove *Your contribution here*.

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

The logo, [assets/logo.svg](assets/logo.svg), shows `42.to_words` returning `"forty-two"`. It was designed with Claude, an AI assistant. Its source is [script/logo.rb](script/logo.rb), which lays out the shapes ([script/logo/layout.rb](script/logo/layout.rb)) and converts the [IBM Plex Mono](https://github.com/IBM/plex) and [Space Grotesk](https://github.com/floriankarsten/space-grotesk) lettering to outlines. The fonts are under the SIL Open Font License and aren't committed. To regenerate the logo, download them and run the script.

```sh
fonts=$(mktemp -d)
curl -sSfL -o "$fonts"/IBMPlexMono-Medium.ttf https://raw.githubusercontent.com/google/fonts/main/ofl/ibmplexmono/IBMPlexMono-Medium.ttf
curl -sSfL -o "$fonts"/SpaceGrotesk-Bold.ttf https://raw.githubusercontent.com/floriankarsten/space-grotesk/master/fonts/ttf/static/SpaceGrotesk-Bold.ttf
ruby script/logo.rb "$fonts" assets/logo.svg
```

Check the result on light and dark backgrounds at full size and in the README, where it is displayed 160 pixels wide.

## Language Documentation

Each language has a page in [docs/languages](docs/languages), linked from the [README](README.md) table. Update it when a language's output or options change: specs check every example and require each option to appear in one. Write examples as `I18n.with_locale(:en) { 21.to_words(ordinal: true) }` on one line, followed by `# => "twenty-first"`. [AGENTS](AGENTS.md) has the details.

Native speakers are especially welcome to review the examples and fix anything that reads wrong. A language is marked experimental while it has known gaps or no native-speaker review; remove the mark in the PR that closes the last gap.

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
