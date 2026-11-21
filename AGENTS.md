# AGENTS

Guidance for AI agents and contributors working on numbers_and_words. See [CONTRIBUTING](CONTRIBUTING.md) for the general workflow.

## Commands

* `bundle install`: install dependencies; no lockfile is committed.
* `bundle exec rake`: run RuboCop and RSpec; CI runs them in the separate Lint and Test workflows.
* `bundle exec rake spec` or `bundle exec rake rubocop`: run one of them.
* `I18N_VERSION=1.6.0 bundle exec rspec`: test against the oldest i18n release CI covers.
* `bundle exec rake build` then `bundle exec ruby script/verify_package.rb`: build the gem and test the installed archive in an isolated consumer, as CI's Package workflow does.
* `bundle exec rake benchmark`: throughput and allocation benchmarks, see [BENCHMARKS](BENCHMARKS.md).

## Where a Language Lives

For a locale such as `fr`:

* `lib/numbers_and_words/i18n/locales/numbers.fr.yml`: the words. `mega` and `micro` list the keys of scale and fraction words by power of 1000.
* `lib/numbers_and_words/translations/fr.rb`: how individual words are chosen (tens with ones, hundreds, scale words, fractions).
* `lib/numbers_and_words/strategies/figures_converter/languages/fr.rb`: how a number is assembled and printed.
* `lib/numbers_and_words/strategies/figures_converter/decorators/fr/`: integral and fractional parts of floats; a locale without decorators cannot convert decimals.
* `lib/numbers_and_words/strategies/figures_converter/options/fr/`: locale-specific options such as `gender` or `ordinal`.
* `lib/numbers_and_words/strategies/array_joiner/languages/fr.rb` and `lib/numbers_and_words/i18n/plurals/` where needed.
* `spec/numbers_and_words/{integer,float,array}/fixture_examples/fr.yml`: expected output. Float fixtures only run for locales in `FLOAT_CAPABLE_LANGUAGES` in `spec/numbers_and_words/numbers_and_words_spec.rb`.
* `docs/languages/fr.md` and its row in the [README](README.md) table.

A new language needs all of these, an entry in the script map in `spec/numbers_and_words/i18n_spec.rb`, and a CHANGELOG entry.

## Invariants Enforced by Specs

* Fixture files have no duplicate keys; YAML would silently drop all but the last.
* Every scale word in every locale translates, for one and two of each power (no `Translation missing`).
* Locale strings use the locale's script, are NFC-normalized and contain no invisible characters; Ukrainian contains no Russian-only letters.
* Every documented example in the README and `docs/languages` is checked: a one-line `I18n.with_locale(:en) { 21.to_words(ordinal: true) }` with a number or array of numbers and literal options, followed by `# => <value>`. Examples are parsed, never evaluated, and any other `I18n.with_locale` line fails. Update the language page whenever output changes.

## Language Changes

* Fixtures are the specification of correct language. Change an expectation only with a linguistic reason, give it in the PR, and add fixtures for the rule's boundaries, not only the reported number.
* Judgement calls go to native speakers; [#255](https://github.com/kslazarev/numbers_and_words/issues/255) collects them.
* An output change that callers might depend on, or a changed option default, is breaking: document it in [UPGRADING](UPGRADING.md) with the old and new output and how to keep the old behavior.
* Floats below `0.0001` print in scientific notation in Ruby; check such inputs separately.

## Packaging and Releases

* `lib/numbers_and_words/version.rb` holds the only version. The gemspec loads it with `require_relative`; a load-path `require` can pick up another copy and breaks release preparation (`spec/release_spec.rb`).
* Consumers support Ruby 3.2 and later; release tooling needs CRuby 3.3+.
* RuboCop and its plugins are pinned to exact versions, so new cops arrive only through deliberate upgrades.
* Releases run only through the manually dispatched workflow described in [RELEASING](RELEASING.md).
