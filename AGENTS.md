# AGENTS

This page guides AI agents and contributors working on numbers_and_words. See [CONTRIBUTING](CONTRIBUTING.md) for the general workflow.

## Commands

* The `bundle install` command installs dependencies; no lockfile is committed.
* The `bundle exec rake` command runs RuboCop and RSpec; CI runs them in the separate Lint and Test workflows.
* The `bundle exec rake spec` and `bundle exec rake rubocop` commands run RSpec or RuboCop alone. RuboCop also lints the Markdown (rubocop-prose, and rubocop-md for Ruby code blocks) and the YAML (rubocop-yaml) on Ruby 3.2 and later; label every code block with its language, since an unlabeled block is linted as Ruby.
* The `I18N_VERSION=1.6.0 bundle exec rspec` command tests against the oldest i18n release CI covers.
* The `bundle exec rake build` command, followed by `bundle exec ruby script/verify_package.rb`, builds the gem and tests the installed archive in an isolated consumer, as CI's Package workflow does.
* The `bundle exec ruby script/features.rb` command regenerates [docs/features.md](docs/features.md) after changing what a language supports; a spec fails when it is out of date.
* The `bundle exec rake benchmark` command runs the throughput and allocation benchmarks, see [BENCHMARKS](BENCHMARKS.md).
* The `bundle exec rspec spec/cldr_comparison_spec.rb` command compares spelled-out integers with the Unicode CLDR spell-out rules; it is also part of `rake spec`.
* The `bundle exec ruby script/cldr_differences.rb` command updates the rule counts in `spec/fixtures/cldr_rules.yml` and the exceptions in `spec/fixtures/cldr_exceptions.yml`, see [CONTRIBUTING](CONTRIBUTING.md#unicode-cldr-comparison).

## Where a Language Lives

Everything about a language belongs in its locale file. Use Ruby only for what rule sets can't say. For a locale such as `fr`, the language lives in these files:

* The locale file, `lib/numbers_and_words/i18n/locales/numbers.fr.yml`, has these keys:
  * The `rules` key holds the rule sets that spell whole numbers and ordinals, in the template syntax documented in `lib/numbers_and_words/rules.rb`.
  * The `supported_options` key lists the options the language accepts, such as `ordinal: true`, or `spelling: {values: [reformed, traditional]}` with an optional `default`.
    * An option that is on reads its words under `numbers.options.<option>`, or under `numbers.options.<value>` for its value (`spelling: :traditional`).
    * The `{rules: hundreds}` value makes an option spell with the `cardinal-hundreds` and `ordinal-hundreds` rule sets.
    * The `ordinal: {minimum: 0, maximum: 9999}` entry limits ordinals; `ordinal: {minimum: 1}` alone limits them only from below.
    * The `remove_zero: {keeps_ordinal_zero: true, keeps_micro_separator: true}` entry keeps the ordinal of zero and the decimal word ("point seven") with `remove_zero`.
  * The `decimals: {integral_gender: female, fractional_gender: female}` entry, at the top of `numbers`, gives the genders of a decimal's parts; `fraction_gender` gives the gender of both parts with `fraction: true`.
  * The `word_separator: ''` entry means that the language is written without spaces between words (Chinese, Japanese, Thai). It applies to decimals, units and the minus word.
  * The `plural` key gives the plural categories of a count, where the language needs more than I18n's `one` and `other`. It uses a subset of the Unicode CLDR plural syntax, such as `one: n % 10 = 1 and n % 100 != 11` (see `lib/numbers_and_words/i18n/plural_rule.rb`).
  * The `mega` and `micro` keys list the keys of scale and fraction words by power of 1000. A number past the last `mega` entry raises `RangeError`. A locale without `mega`, such as Japanese, sets its limit with its own scale table, or has none.
  * The `minus` key holds the word read before a negative number.
  * The `unit` option reads these keys (see `lib/numbers_and_words/unit/`):
    * The `subunit_separator` and `subunit_separator_attached` keys join a unit and its subunit.
    * The `unit_scale_preposition` key gives the preposition after a scale word, with `unit_scale_preposition_elided` and the letters it is elided before, `unit_scale_preposition_elided_before`.
    * The `before_unit` and `unit_order` keys give the form and position of a number before its unit.
    * The `unit_after_decimal` key gives the form after a decimal (`{form: few}`, or `{below_two: one}`).
    * The `unit_after_zero` key gives the form after zero (`one`).
  * The `extends: fr` entry, in a regional locale such as `fr-CH`, makes the locale take the other's numbers and list only what differs. A key set to `~` drops one of the other's keys, such as a rule (`lib/numbers_and_words/i18n/extends.rb`). Its generated classes extend the other's, and it uses the other's decorators.
* Where needed, Ruby classes under `lib/numbers_and_words/` hold the rest. Each is generated for a language that doesn't define it:
  * The class in `strategies/figures_converter/languages/fr.rb` includes `RuleSets`. It picks other rule sets (`cardinal_set`, `ordinal_set`) or word scopes (`option_words`) where the locale file can't, such as for English `pronounced`, which depends on the number. `RuleSets` uses the rule set of the `gender:` option, such as `cardinal-female`, if there is one, and `cardinal` otherwise.
  * The class in `translations/fr.rb` holds words the decorators and array joiner read that `Translations::Base` doesn't, such as fractions with their own grammar.
  * The decorators in `strategies/figures_converter/decorators/fr/` handle the integral and fractional parts of decimals. A missing decorator leaves its part as it is. `Decorators::Base` gives the fraction word for the fractional part (`fraction_significance`). Without decorators of its own, a language reads decimals only in these cases:
    * Its locale file sets `decimals: {reading: counted_fraction}` for a shared reading in `decorators/`, such as `CountedFraction` or `Digits`, or another language's decorators (`reading: cs`), followed in turn.
    * Its locale file sets `reading: plain`, which reads decimals with no decorators.
    * It is a regional locale, which uses the decorators of the one it extends.
  * The class in `strategies/array_joiner/languages/fr.rb` joins the parts of a decimal, if not as `ArrayJoiner::Languages::Base` does.
  * The classes in `strategies/figures_converter/options/fr/` implement an option with checks of its own, extending `Options::Option`, such as `Options::Pl::Gender`.
* The fixtures in `spec/numbers_and_words/{integer,float,array}/fixture_examples/fr.yml` hold the expected output. Float fixtures run for the locales in `FLOAT_CAPABLE_LANGUAGES` in `spec/numbers_and_words/numbers_and_words_spec.rb`.
* The page `docs/languages/fr.md` and its row in the [README](README.md) table document the language.

The `gender:` and `animate:` options pick a rule set. The `case:` option picks the words under `numbers.cases`; a case without words, such as the Ukrainian vocative, uses the nominative. Ordinals are declined through `numbers.ordinals.endings` or spelled with the words under `numbers.genders.<gender>`. Chinese, Japanese and Korean share `languages/myriad.rb`, and Chinese groups by 10,000 in `languages/zh.rb`.

The `to_words` method ignores an undeclared option with a warning, and raises with `NumbersAndWords.config.strict_options = true`. The global options in `OptionsValidation::GLOBAL` need no declaration. Don't pass internal options such as `integral` or `fractional` through `Integer#to_words`; call the wrappers directly. Write error messages as sentences, such as `Ordinals in :ar only support numbers between 1 and 99.`. Use `Translations::Families::Base.range_error`, `decimal_range_error` or `ordinal_range_error` for the shared ones.

Read locale data with `NumbersAndWords::I18n.t`, and derive values from it with `NumbersAndWords::I18n.cached`, not with `::I18n.t` on every conversion. With I18n's Simple backend, both keep the result until the backend stores or reloads translations (`lib/numbers_and_words/i18n/invalidation.rb`). With another backend, they look it up each time. Check a change to a conversion path with `bundle exec rake benchmark`.

A language reads decimals, declares `gender` if its numbers agree in gender, and spells ordinals up to its largest number. Where the language has scale words, it lists them up to at least 10<sup>36</sup>, or as far as Unicode CLDR goes. A new language starts with all of these; its page explains any gap. It also needs an entry in the script map in `spec/numbers_and_words/i18n_spec.rb` and a CHANGELOG entry.

## Invariants Enforced by Specs

* Fixture files have no duplicate keys; YAML would silently drop all but the last.
* Every scale word in every locale translates, for one and two of each power (no `Translation missing`).
* Locale strings use the locale's script, are NFC-normalized and contain no invisible characters; Ukrainian contains no Russian-only letters.
* Every example in the README and `docs/languages` is checked. An example is one line such as `I18n.with_locale(:en) { 21.to_words(ordinal: true) }`, with literal numbers and options, followed by `# => <value>`. Examples are parsed, never evaluated, and any other `I18n.with_locale` line fails.
* Every option a language accepts appears in an example on its page, and every global option in the README. Examples of `unit`, `subunit` and `zero_subunit` use the translations in the README's `### Unit` YAML block.

## Language Changes

* Fixtures are the specification of correct language. Change an expectation only for a linguistic reason, and give it in the PR. Add fixtures for the rule's boundaries, not only the reported number.
* An output change can add, change or remove a difference from Unicode CLDR. Run `script/cldr_differences.rb`, then:
  * Cover a repeated difference with a literal rule in `spec/fixtures/cldr_rules.yml` rather than many exceptions. Rules may only use the operations in `spec/support/cldr_rules.rb`, never patterns.
  * Give a specific reason for each new rule or exception, and explain every changed `affects` count.
  * Fix a difference where the gem is wrong; it is a bug, not a rule or exception.
  * Reference a CLDR error's Jira ticket (such as CLDR-19918) with `ticket:`.
* Judgement calls go to native speakers; [#255](https://github.com/kslazarev/numbers_and_words/issues/255) collects them.
* An output change that callers might depend on, or a changed option default, is breaking. Until 2.0, keep the old behavior in `lib/numbers_and_words/compatibility.rb`. A 1.x default goes in the option's `legacy_default` under `numbers.supported_options`, next to its 2.0 `default`, and warns once. Document the change in [UPGRADING](UPGRADING.md) with the old and new output and how to choose. A fix of wrong output isn't breaking, but still goes in UPGRADING.
* Specs test the 2.0 behavior, with `strict_options = true` and without the 1.x defaults (see `spec/spec_helper.rb`). Specs tagged `:compatibility`, such as the documentation examples and `spec/numbers_and_words/compatibility_spec.rb`, run with the 1.x defaults.
* Floats below `0.0001` print in scientific notation in Ruby; check such inputs separately.

## Packaging and Releases

* The file `lib/numbers_and_words/version.rb` holds the only version. The gemspec loads it with `require_relative`. A load-path `require` can pick up another copy and breaks release preparation (`spec/release_spec.rb`).
* The gem ships the `to_words` command (`bin/to_words`, `lib/numbers_and_words/cli.rb`). It generates one flag per option from `OptionsValidation` and leaves validation to `to_words`. A new option gets a flag automatically; add its description to `CLI::DESCRIPTIONS`.
* Consumers support Ruby 3.1 and later; release tooling needs CRuby 3.3+.
* RuboCop and its plugins are pinned to exact versions, so new cops arrive only through deliberate upgrades.
* Releases run only through the manually dispatched workflow described in [RELEASING](RELEASING.md).
