# Upgrading

## Upgrading to 2.0.0

### Unsupported Options Raise an Error

`to_words` used to ignore options a language does not support, and invalid values could return wrong or garbage output. Each language now accepts only the global options `precision` and `micro_separator`, plus the options listed on its [language page](docs/languages). Anything else raises `NumbersAndWords::UnsupportedOptionError`, a subclass of `ArgumentError`, naming the supported alternatives.

```ruby
I18n.with_locale(:vi) { 21.to_words(gender: :female) }
# 1.0.x => "hai mươi mốt"
# 2.0.0 => NumbersAndWords::UnsupportedOptionError: unsupported option :gender for locale :vi; supported: :micro_separator, :ordinal, :precision, :remove_zero, :subunit, :unit, :zero_subunit

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

To keep the 1.0.x spelling, pass `spelling: :traditional`:

```ruby
I18n.with_locale(:fr) { 321.to_words(spelling: :traditional) }
# => "trois cent vingt et un"
```

See [#257](https://github.com/kslazarev/numbers_and_words/pull/257) and [#264](https://github.com/kslazarev/numbers_and_words/issues/264) for details.

### More Natural Forms in Several Languages

Several languages now use the forms people usually say and write, as reviewed in [#255](https://github.com/kslazarev/numbers_and_words/issues/255). There are no options to restore the previous forms.

| Language | Number | 1.0.x | 2.0.0 |
| --- | --- | --- | --- |
| Czech (`cs`) | 100, 1000 | `jedno sto`, `jeden tisíc` | `sto`, `tisíc` |
| Danish (`da`) | 1, 1000 | `et`, `et tusinde` | `en`, `et tusind` |
| Hungarian (`hu`) | 100, 1000, 2000 | `egyszáz`, `egyezer`, `kettőezer` | `száz`, `ezer`, `kétezer` |
| Italian (`it`) | 21,000,000 | `ventuno milioni` | `ventun milioni` |
| Kazakh (`kk`) | 100, 1000 | `бір жүз`, `бір мың` | `жүз`, `мың` |
| Armenian (`hy`) | 1000 | `մեկ հազար` | `հազար` |
| Lithuanian (`lt`) | 10⁹, 10¹² | `bilijonas`, `trilijonas` | `milijardas`, `trilijonas` |
| Spanish (`es`) | 901, feminine and apocopated | `novecientas un` | `novecientas una` |

- **Danish:** 1 is now the counting form `en`. `gender: :neuter` still gives `et`, and hundreds and thousands still take `et`.
- **Hungarian:** `két` replaces `kettő` before a scale word or hundreds, as in `huszonkétezer`. A final `kettő` is unchanged, as in `huszonkettő`.
- **Spanish:** `apocopated: true` now shortens only the masculine `uno`.

See [#289](https://github.com/kslazarev/numbers_and_words/pull/289) for details.

### Decimals Are Read With a Decimal Point

English, French, Swiss French, Italian, Portuguese and Brazilian Portuguese now read decimals with a decimal point, as British English already did, rather than as a fraction. English reads each fractional digit. The other languages read up to three decimal places as a number after one zero for each leading zero, and longer ones digit by digit.

| Language | Number | 1.0.x | 2.0.0 |
| --- | --- | --- | --- |
| English (`en`) | 21.77 | `twenty-one and seventy-seven hundredths` | `twenty-one point seven seven` |
| French (`fr`) | 3.05 | `trois et cinq centièmes` | `trois virgule zéro cinq` |
| Italian (`it`) | 21.77 | `ventuno e settantasette centesimi` | `ventuno virgola settantasette` |
| Portuguese (`pt`, `pt-BR`) | 21.77 | `vinte e um inteiros e setenta e sete centésimos` | `vinte e um vírgula setenta e sete` |

To keep the fraction reading, pass `fraction: true`. British English accepts it too.

```ruby
I18n.with_locale(:en) { 21.77.to_words(fraction: true) }
# => "twenty-one and seventy-seven hundredths"
```

With `remove_zero: true`, the decimal point stays: `0.7` is `point seven`, or `seven tenths` with `fraction: true`.

### Czech Ordinals of Thousands

Czech ordinals from 1,000 to 9,999 now start with a single word for the thousands (`tisící`, `dvoutisící`), and ordinals of 10,000 or more raise `RangeError` instead of returning wrong words.

```ruby
I18n.with_locale(:cs) { 1984.to_words(ordinal: true, gender: :male) }
# 1.0.x => "první tisíc devítistý osmdesátý čtvrtý"
# 2.0.0 => "tisící devítistý osmdesátý čtvrtý"
```

### Unsupported Languages Raise `NumbersAndWords::UnsupportedLanguageError`

Converting in a locale without bundled rules, or one that `NumbersAndWords.config.locales` disables, raises `NumbersAndWords::UnsupportedLanguageError`, with the same messages as before (`Language not supported`, `Language not configured`). In 1.0.x these were plain `RuntimeError`s. The new class is a `StandardError`, not a `RuntimeError`, so replace `rescue RuntimeError` with `rescue NumbersAndWords::UnsupportedLanguageError`. A bare `rescue` or `rescue StandardError` still catches it.

```ruby
begin
  I18n.with_locale(:am) { 42.to_words }
rescue NumbersAndWords::UnsupportedLanguageError => e
  e.message # => "Language not supported"
end
```

See [#293](https://github.com/kslazarev/numbers_and_words/pull/293) for details.

### Swedish, Ukrainian and Kazakh Use Standard Locale Codes

Three languages were bundled under non-standard codes: `se` is actually Northern Sami, and `ua` and `kz` are country codes. They now use the standard ISO 639-1 codes, so an application whose `I18n.locale` is `:sv`, `:uk` or `:kk` (or a regional variant such as `sv-SE`, `uk-UA` or `kk-KZ`) converts numbers. The old codes are no longer accepted and raise `NumbersAndWords::UnsupportedLanguageError` like any unsupported locale.

| Language | 1.0.x | 2.0.0 |
| --- | --- | --- |
| Swedish | `se` | `sv` |
| Ukrainian | `ua` | `uk` |
| Kazakh | `kz` | `kk` |

```ruby
I18n.with_locale(:uk) { 21.to_words }
# 1.0.x => raises "Language not supported" (and :ua => "двадцять один")
# 2.0.0 => "двадцять один"
```

To migrate, replace the old codes wherever your application uses them:

- `I18n.with_locale`, `I18n.locale` and `I18n.available_locales`;
- `NumbersAndWords.config.locales` and `fallback:`;
- any application translations that override the gem's locale files: the files are now `numbers.sv.yml`, `numbers.uk.yml` and `numbers.kk.yml`, with top-level keys `sv:`, `uk:` and `kk:`.

See [#300](https://github.com/kslazarev/numbers_and_words/pull/300) for details.
