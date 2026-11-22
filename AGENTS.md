# AGENTS

Guidance for AI agents and contributors working on numbers_and_words. See [CONTRIBUTING](CONTRIBUTING.md) for the general workflow.

## Commands

* `bundle install`: install dependencies; no lockfile is committed.
* `bundle exec rake`: run RuboCop and RSpec; CI runs them in the separate Lint and Test workflows.
* `bundle exec rake spec` or `bundle exec rake rubocop`: run one of them.
* `I18N_VERSION=1.6.0 bundle exec rspec`: test against the oldest i18n release CI covers.
* `bundle exec rake build` then `bundle exec ruby script/verify_package.rb`: build the gem and test the installed archive in an isolated consumer, as CI's Package workflow does.
* `bundle exec rake benchmark`: throughput and allocation benchmarks, see [BENCHMARKS](BENCHMARKS.md).
* `bundle exec rspec spec/cldr_comparison_spec.rb`: compare spelled-out integers with the Unicode CLDR spell-out rules (part of `rake spec`); `bundle exec ruby script/cldr_differences.rb` updates the rule counts in `spec/fixtures/cldr_rules.yml` and the exceptions in `spec/fixtures/cldr_exceptions.yml`, see [CONTRIBUTING](CONTRIBUTING.md#unicode-cldr-comparison).

## Where a Language Lives

Everything about a language belongs in its locale file; Ruby is only for what rule sets can't say. For a locale such as `fr`:

* `lib/numbers_and_words/i18n/locales/numbers.fr.yml`:
  * `rules`: the rule sets that spell whole numbers and ordinals, in the template syntax documented in `lib/numbers_and_words/rules.rb`.
  * `supported_options`: the options the language accepts, such as `ordinal: true`, or `spelling: {values: [reformed, traditional]}` with an optional `default`. `ordinal: {minimum: 0, maximum: 9999}` limits ordinals; `remove_zero: {keeps_ordinal_zero: true, keeps_micro_separator: true}` keeps the ordinal of zero and the decimal word ("point seven") with `remove_zero`.
  * `mega` and `micro`: the keys of scale and fraction words by power of 1000; a number past the last `mega` entry raises `RangeError`, and a locale without `mega` has no limit. `minus` is read before a negative number.
  * For `unit`: `subunit_separator` (with `subunit_separator_attached`), `before_unit` and `unit_order`; see `lib/numbers_and_words/unit/`.
  * `extends: fr`, in a regional locale such as `fr-CH`: the locale takes the other's numbers and only lists what differs; a key set to `~` drops one of the other's, such as a rule (`lib/numbers_and_words/i18n/extends.rb`).
* Where needed, Ruby classes under `lib/numbers_and_words/`, each generated for a language without one:
  * `strategies/figures_converter/languages/fr.rb`: includes `RuleSets` and picks rule sets (`cardinal_set`, `ordinal_set`) or word scopes (`option_words`) from the options. `RuleSets` uses the rule set of the `gender:` option, such as `cardinal-female`, where there is one, and `cardinal` otherwise.
  * `translations/fr.rb`: words the decorators and array joiner read that `Translations::Base` doesn't, such as fractions with their own grammar.
  * `strategies/figures_converter/decorators/fr/`: the integral and fractional parts of decimals. A missing decorator leaves its part as it is; `Decorators::SHARED` uses another language's, and `Decorators::PLAIN` reads decimals with none. Other languages without decorators don't read decimals.
  * `strategies/array_joiner/languages/fr.rb`: how the parts of a decimal join, if not as `ArrayJoiner::Languages::Base` does.
  * `strategies/figures_converter/options/fr/`: an option with checks of its own, extending `Options::Option`, such as `Options::Pl::Gender`.
* `lib/numbers_and_words/i18n/plurals/`, where needed.
* `spec/numbers_and_words/{integer,float,array}/fixture_examples/fr.yml`: expected output. Float fixtures run for the locales in `FLOAT_CAPABLE_LANGUAGES` in `spec/numbers_and_words/numbers_and_words_spec.rb`.
* `docs/languages/fr.md` and its row in the [README](README.md) table.

`gender:` and `animate:` pick a rule set, `case:` the words under `numbers.cases` (a case without words, such as the Ukrainian vocative, uses the nominative), and ordinals are declined through `numbers.ordinals.endings` or spelled with the words under `numbers.genders.<gender>`. Hindi, Bengali and Urdu share the Indian decimal reading in `decorators/indian.rb`; Chinese, Japanese and Korean share `languages/myriad.rb`, and Chinese groups by 10,000 in `languages/zh.rb`.

`to_words` ignores an undeclared option, except the global ones in `OptionsValidation::GLOBAL`, with a warning, and raises with `NumbersAndWords.config.strict_options = true`. Internal options such as `integral` or `fractional` must not go through `Integer#to_words`; call the wrappers directly. Error messages are sentences, such as `Ordinals in :ar only support numbers between 1 and 99.`; use `Translations::Families::Base.range_error`, `decimal_range_error` or `ordinal_range_error` for the shared ones.

A new language needs all of these, an entry in the script map in `spec/numbers_and_words/i18n_spec.rb`, and a CHANGELOG entry.

## Invariants Enforced by Specs

* Fixture files have no duplicate keys; YAML would silently drop all but the last.
* Every scale word in every locale translates, for one and two of each power (no `Translation missing`).
* Locale strings use the locale's script, are NFC-normalized and contain no invisible characters; Ukrainian contains no Russian-only letters.
* Every example in the README and `docs/languages` is checked: one line such as `I18n.with_locale(:en) { 21.to_words(ordinal: true) }`, with literal numbers and options, followed by `# => <value>`. Examples are parsed, never evaluated; any other `I18n.with_locale` line fails. Every option a language accepts appears in an example on its page, and every global option in the README; `unit`, `subunit` and `zero_subunit` examples use the translations in the README's `### Unit` YAML block.

## Language Changes

* Fixtures are the specification of correct language. Change an expectation only with a linguistic reason, give it in the PR, and add fixtures for the rule's boundaries, not only the reported number.
* An output change can add, change or remove a difference from Unicode CLDR: run `script/cldr_differences.rb`, cover a repeated difference with a literal rule in `spec/fixtures/cldr_rules.yml` rather than many exceptions, give a specific reason for each new rule or exception, and explain every changed `affects` count. Rules may only use the operations in `spec/support/cldr_rules.rb`, never patterns. A difference where the gem is wrong is a bug to fix, not a rule or exception. Reference a CLDR error's Jira ticket (such as CLDR-19918) with `ticket:`.
* Judgement calls go to native speakers; [#255](https://github.com/kslazarev/numbers_and_words/issues/255) collects them.
* An output change that callers might depend on, or a changed option default, is breaking: until 2.0, keep the old behavior in `lib/numbers_and_words/compatibility.rb` (a default goes in `Compatibility::DEFAULTS` and warns once), and document it in [UPGRADING](UPGRADING.md) with the old and new output and how to choose. A fix of wrong output isn't breaking, but still goes in UPGRADING.
* Specs test the 2.0 behavior, with `strict_options = true` and without `Compatibility::DEFAULTS` (see `spec/spec_helper.rb`); specs tagged `:compatibility`, such as the documentation examples and `spec/numbers_and_words/compatibility_spec.rb`, run with the 1.x defaults.
* Floats below `0.0001` print in scientific notation in Ruby; check such inputs separately.

## Packaging and Releases

* `lib/numbers_and_words/version.rb` holds the only version. The gemspec loads it with `require_relative`; a load-path `require` can pick up another copy and breaks release preparation (`spec/release_spec.rb`).
* The gem ships the `to_words` command (`bin/to_words`, `lib/numbers_and_words/cli.rb`). It generates one flag per option from `OptionsValidation`, so a new option gets a flag automatically, and leaves validation to `to_words`; add a description to `CLI::DESCRIPTIONS`.
* Consumers support Ruby 3.1 and later; release tooling needs CRuby 3.3+.
* RuboCop and its plugins are pinned to exact versions, so new cops arrive only through deliberate upgrades.
* Releases run only through the manually dispatched workflow described in [RELEASING](RELEASING.md).
