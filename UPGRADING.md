# Upgrading

## Upgrading to 2.0.0

### Unsupported Options Raise an Error

`to_words` used to ignore options a language does not support, and invalid values could return wrong or garbage output. Each language now accepts only the global options `precision` and `micro_separator`, plus the options listed on its [language page](docs/languages). Anything else raises `NumbersAndWords::UnsupportedOptionError`, a subclass of `ArgumentError`, naming the supported alternatives.

```ruby
I18n.with_locale(:fr) { 21.to_words(ordinal: true) }
# 1.0.x => "vingt et un"
# 2.0.0 => NumbersAndWords::UnsupportedOptionError: unsupported option :ordinal for locale :fr; supported: :micro_separator, :precision

I18n.with_locale(:es) { 1.to_words(gender: :neuter) }
# 1.0.x => "r"
# 2.0.0 => NumbersAndWords::UnsupportedOptionError: unsupported value :neuter for option :gender in locale :es; supported: :male, :female
```

Remove options that a language does not support, or pass options only for the locales that accept them. Flags such as `ordinal` accept only `true` or `false`, `precision` a non-negative integer, and `micro_separator` a string. Options are listed per language in [docs/languages](docs/languages).

See [#269](https://github.com/kslazarev/numbers_and_words/pull/269) and [#266](https://github.com/kslazarev/numbers_and_words/issues/266) for details.

### British English Says "and" After Hundreds

British English (`en-GB`) now adds "and" after hundreds by default, as British usage requires. Previously `en-GB` produced the American form unless `hundreds_with_union: true` was passed. American English (`en`) is unchanged.

```ruby
I18n.with_locale(:'en-GB') { 101.to_words }
# 1.0.x => "one hundred one"
# 2.0.0 => "one hundred and one"
```

To keep the previous output, pass `hundreds_with_union: false`:

```ruby
I18n.with_locale(:'en-GB') { 101.to_words(hundreds_with_union: false) }
# => "one hundred one"
```

See [#251](https://github.com/kslazarev/numbers_and_words/pull/251) for details.

### French Uses the 1990 Spelling Reform

French (`fr`) and Swiss French (`fr-CH`) now follow the 1990 spelling reform (*rectifications de l'orthographe*), hyphenating every numeral in a compound number. The nouns `million`, `milliard` and larger stay separate words, and the plural agreement of `vingts` and `cents` is unchanged.

```ruby
I18n.with_locale(:fr) { 321.to_words }
# 1.0.x => "trois cent vingt et un"
# 2.0.0 => "trois-cent-vingt-et-un"

I18n.with_locale(:fr) { 2_000_021.to_words }
# 1.0.x => "deux millions vingt et un"
# 2.0.0 => "deux millions vingt-et-un"
```

See [#257](https://github.com/kslazarev/numbers_and_words/pull/257) for details.
