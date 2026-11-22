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

Run `bundle exec rake spec` for tests only or `bundle exec rake rubocop` for lint only. CI runs tests on Ruby 3.1 and later, JRuby, macOS and Windows.

`bundle exec rake build` and then `bundle exec ruby script/verify_package.rb` install the built gem in a throwaway directory and exercise it there.

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

Write a test that reproduces the problem you're fixing or describes the feature you're building, in [spec](spec).

Pull requests that only reproduce a problem, without a fix, are welcome too.

#### Locale Character Validation

Locale strings must use the locale's script, be NFC-normalized, and contain no invisible characters. When adding a locale, register its script in `spec/numbers_and_words/i18n_spec.rb`. Run these checks with `bundle exec rspec spec/locale_characters_spec.rb spec/numbers_and_words/i18n_spec.rb`.

#### Unicode CLDR Comparison

`spec/cldr_comparison_spec.rb` spells integers from 0 to 123,456,789 with this gem and with the [Unicode CLDR](https://cldr.unicode.org/) spell-out rules (RBNF), from the development-only [twitter_cldr](https://github.com/ruby-i18n/twitter-cldr-rb) gem, for each language CLDR covers: cardinals, ordinals, and each gender the gem accepts. `CldrComparison::LOCALES` in `spec/support/cldr_comparison.rb` maps each locale to its CLDR rule sets and lists skipped locales with the reason. Run it alone with `bundle exec rspec spec/cldr_comparison_spec.rb`.

Every difference is reviewed. `spec/fixtures/cldr_rules.yml` holds rules, per locale or shared under `"*"`, that transform CLDR's reading before the comparison, each with a reason: a CLDR convention or error, or a variant in use. A rule does one literal operation, so it can't hide an unrelated difference: `replace` whole words or phrases, `replace_parts` of words such as a misspelled stem, `drop_one` the implicit one before listed scale words, add a `prefix`, `split_before` listed word parts, `join_before`/`join_after` words beginning or ending with listed parts, or `hyphenate` all words except next to listed ones; `kinds`, `above` and `below` limit it to some comparisons. Each rule records with `affects` how many comparisons it changes. A difference no rule explains is an exception in `spec/fixtures/cldr_exceptions.yml`, with both readings and the reason. The spec fails on any other difference, on an exception that no longer differs, on a rule that changes a reading CLDR agrees with, and on a changed `affects` count, so a rule that starts absorbing a new difference, or stops applying, is noticed.

After a deliberate output change, or upgrading twitter_cldr, run `bundle exec ruby script/cldr_differences.rb`: it updates the `affects` counts, rewrites the exceptions, keeping the reasons of unchanged ones and marking new ones `TODO`, and lists new differences by the substitution they need, as candidate rules. Write a rule for a repeated difference, give each `TODO` a reason, or fix the gem when it's wrong; then explain every changed `affects` count. Report CLDR errors to the [CLDR Jira](https://unicode-org.atlassian.net/jira/software/c/projects/CLDR/issues) and reference the ticket in the rule with `ticket:` (for example `ticket: CLDR-19918`) or in the exception's reason. CLDR is a reference, not the specification: the fixtures are.

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
