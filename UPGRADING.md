# Upgrading

## Upgrading to Version 1.2.0

The public API, `to_words` with the options in the README and on each language page, is unchanged. So is its output in every language, except as described below.

### Error and Warning Messages Are Sentences

Error and warning messages start with a capital letter and end with a period. The ordinal range errors of Arabic, Czech, Greek and Polish share one message. The error classes don't change, so rescue them rather than matching messages.

| 1.1 | 1.2 |
| --- | --- |
| `numbers must be below 10**30 in :cs` | `Numbers in :cs only support values below 10**30.` |
| `decimals are not supported in :sv` | `Decimals are not supported in :sv.` |
| `Arabic ordinals support 1 to 99` | `Ordinals in :ar only support numbers from 1.` (Arabic ordinals from 100 now read) |
| `unsupported option :gender for locale :vi; supported: ...` | `The option :gender is not supported in :vi; supported: ....` |

An ordinal too large for any words in those four languages now raises the cardinal `RangeError`, as Greek already did.

### Newly Supported Options Change Output

Options that a language ignored with a warning in 1.1 now apply, so calls that pass them change:

| Option | Languages | 1.1 | 1.2 |
| --- | --- | --- | --- |
| `remove_zero: true` | ar, da, et, hy, ka, kk, lt, lv, sv, tr | `0.to_words(remove_zero: true)` is "nul" (Danish), with a warning | "" |
| `gender:`, or a unit with a `gender` | ar, de, fr, fr-CH, it, lt, lv, sv | `21.to_words(unit: :heure)` with `gender: female` is "vingt et un heures" | "vingt et une heures" |
| `case:` | pl | ignored with a warning | declines cardinals; with `ordinal: true`, a decimal or a unit, raises `NumbersAndWords::UnsupportedOptionError` |

Some calls that raised now return words:

* Decimals read in every language instead of raising `NumbersAndWords::UnsupportedNumberError`.
* Larger numbers read instead of raising `RangeError`, up to 10<sup>36</sup> in every language with scale words.
* Arabic, Czech, Greek and Polish ordinals of every size read.
* A `precision` shorter than a decimal's fractional part rounds it (`0.129.to_words(precision: 2)` reads 0.13) instead of raising `ArgumentError`.

### Internals Moved Into the Locale Files

Each language now spells numbers from rule sets in its locale file (`numbers.rules`) and lists its options there (`numbers.supported_options`). British English and Swiss French list only what differs from English and French. Many of the gem's classes and translation keys are gone or renamed. Code that reached into those classes, such as `NumbersAndWords::Strategies::FiguresConverter::Options::En::Ordinal` or `NumbersAndWords::Translations::Families::Latin`, or that overrode translations under `numbers.*`, may need changes.

## Upgrading to Version 1.1.0

Version 1.1.0 keeps the 1.0 behavior that callers may rely on, warns about what 2.0 will change, and fixes wrong output. To choose a default that 2.0 changes, and silence its warning, pass the option explicitly. This works in both 1.1 and 2.0. To raise for unsupported options now, as 2.0 will, set `strict_options`.

```ruby
NumbersAndWords.config.strict_options = true
```

Each warning is shown once per process. Warnings about changed defaults are deprecation warnings, which Ruby shows only with `Warning[:deprecated] = true` or `ruby -W:deprecated`. The others are always shown.

### Deprecated: Unsupported Options Are Ignored

The `to_words` method used to ignore options a language doesn't support, and an invalid value could return garbage. Each language accepts the global options (`precision`, `micro_separator`, `fallback`, `unit`, `subunit` and `zero_subunit`) and the options on its [language page](docs/languages). Version 1.1.0 ignores anything else with a warning. Version 2.0 will raise `NumbersAndWords::UnsupportedOptionError`, an `ArgumentError`, as 1.1.0 does with `NumbersAndWords.config.strict_options = true`.

```ruby
I18n.with_locale(:vi) { 21.to_words(gender: :female) }
# 1.0.x => "hai mươi mốt"
# 1.1.0 => "hai mươi mốt", warns "unsupported option :gender for locale :vi; supported: ...; ignored, set NumbersAndWords.config.strict_options = true to raise, the default in 2.0"

I18n.with_locale(:es) { 1.to_words(gender: :neuter) }
# 1.0.x => "r"
# 1.1.0 => "uno", with a warning
```

Pass each option only to the locales that accept it. Flags such as `ordinal` accept only `true` or `false`. See [#269](https://github.com/kslazarev/numbers_and_words/pull/269) and [#266](https://github.com/kslazarev/numbers_and_words/issues/266).

### Deprecated: Decimals Are Read as a Fraction by Default

English, French, Swiss French, Italian and Portuguese read decimals as a fraction by default, as in 1.0. The `fraction: false` option reads them with a decimal point, as British English does. Version 2.0 will make it the default. With a decimal point, English reads each digit after the point. Brazilian Portuguese reads up to six decimal places as a number (`três vírgula mil quatrocentos e dezesseis`). The others read up to three decimal places as a number, and longer ones digit by digit.

| Language | Number | 1.0.x, 1.1.0 | `fraction: false`, 2.0.0 |
| --- | --- | --- | --- |
| English (`en`) | 21.77 | `twenty-one and seventy-seven hundredths` | `twenty-one point seven seven` |
| French (`fr`) | 3.05 | `trois et cinq centièmes` | `trois virgule zéro cinq` |
| Italian (`it`) | 21.77 | `ventuno e settantasette centesimi` | `ventuno virgola settantasette` |
| Portuguese (`pt`, `pt-BR`) | 21.77 | `vinte e um inteiros e setenta e sete centésimos` | `vinte e um vírgula setenta e sete` |

```ruby
I18n.with_locale(:en) { 21.77.to_words(fraction: false) }
# => "twenty-one point seven seven"
```

To keep the fraction reading in 2.0, pass `fraction: true`. British English accepts it too. With `remove_zero: true`, `0.7` is `seven tenths`, or `point seven` with `fraction: false`. Amounts with a [`unit`](README.md#unit) read decimals with a decimal point in every version. See [#289](https://github.com/kslazarev/numbers_and_words/pull/289).

### Deprecated: French Uses the Traditional Spelling by Default

French (`fr`) and Swiss French (`fr-CH`) use the traditional spelling by default, as in 1.0. The `spelling: :reformed` option follows the 1990 spelling reform: it hyphenates every numeral in a compound number except the nouns `million`, `milliard` and larger. Version 2.0 will make it the default.

```ruby
I18n.with_locale(:fr) { 321.to_words }
# 1.0.x, 1.1.0 => "trois cent vingt et un"
# 2.0.0 => "trois-cent-vingt-et-un"

I18n.with_locale(:fr) { 2_000_021.to_words(spelling: :reformed) }
# => "deux millions vingt-et-un"
```

To keep the traditional spelling in 2.0, pass `spelling: :traditional`. See [#257](https://github.com/kslazarev/numbers_and_words/pull/257) and [#264](https://github.com/kslazarev/numbers_and_words/issues/264).

### Deprecated: British English Omits "and" After Hundreds by Default

British English (`en-GB`) omits "and" by default, as in 1.0. The `hundreds_with_union: true` option adds it after hundreds, and after thousand, million or a larger scale before a final part below one hundred. Version 2.0 will make it the default. American English (`en`) won't change.

```ruby
I18n.with_locale(:'en-GB') { 101.to_words }
# 1.0.x, 1.1.0 => "one hundred one"
# 2.0.0 => "one hundred and one"

I18n.with_locale(:'en-GB') { 1001.to_words(hundreds_with_union: true) }
# => "one thousand and one"
```

To keep the 1.0 output in 2.0, pass `hundreds_with_union: false`. See [#251](https://github.com/kslazarev/numbers_and_words/pull/251).

### Deprecated: Swedish, Ukrainian and Kazakh Locale Codes

Three languages used non-standard codes: `se` is Northern Sami, and `ua` and `kz` are country codes. The gem now uses the ISO 639-1 codes, including in regional variants such as `sv-SE`. The old codes still convert, with a warning. Version 2.0 will raise `NumbersAndWords::UnsupportedLanguageError` for them.

| Language | 1.0.x | 1.1.0 | 2.0.0 |
| --- | --- | --- | --- |
| Swedish | `se` | `sv`, or `se` with a warning | `sv` |
| Ukrainian | `ua` | `uk`, or `ua` with a warning | `uk` |
| Kazakh | `kz` | `kk`, or `kz` with a warning | `kk` |

```ruby
I18n.with_locale(:uk) { 21.to_words }
# 1.0.x => raises "Language not supported" (and :ua => "двадцять один")
# 1.1.0 => "двадцять один"
```

Replace the old codes in `I18n` locales, `NumbersAndWords.config.locales` and `fallback:`. The gem's locale files are now `numbers.sv.yml`, `numbers.uk.yml` and `numbers.kk.yml`, looked up under the new codes. So move application overrides of the gem's `numbers.*` translations from `se`, `ua` and `kz` to `sv`, `uk` and `kk` now. See [#300](https://github.com/kslazarev/numbers_and_words/pull/300).

### Unsupported Languages Raise `NumbersAndWords::UnsupportedLanguageError`

Unsupported or disabled locales raise `NumbersAndWords::UnsupportedLanguageError`. It is a `RuntimeError`, as before, with the same messages, so `rescue RuntimeError` still works. The error can now also be rescued by name. See [#293](https://github.com/kslazarev/numbers_and_words/pull/293).

```ruby
begin
  I18n.with_locale(:am) { 42.to_words }
rescue NumbersAndWords::UnsupportedLanguageError => e
  e.message # => "Language not supported"
end
```

### Fixes That Change Output

The following fix wrong output and can't be turned off.

#### More Natural Forms in Several Languages

Several languages now use the usual forms, as reviewed in [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

| Language | Number | 1.0.x | 1.1.0 |
| --- | --- | --- | --- |
| Czech (`cs`) | 100, 1000 | `jedno sto`, `jeden tisíc` | `sto`, `tisíc` |
| Czech (`cs`) | 2, 22 without `gender` | `dvě`, `dvacet dvě` | `dva`, `dvacet dva` |
| Dutch (`nl`) | 10²⁴, 10²⁷ | `één septiljoen`, `één octillion` | `één quadriljoen`, `één quadriljard` |
| Danish (`da`) | 1, 1000 | `et`, `et tusinde` | `en`, `et tusind` |
| Hungarian (`hu`) | 100, 1000, 2000 | `egyszáz`, `egyezer`, `kettőezer` | `száz`, `ezer`, `kétezer` |
| Hungarian (`hu`) | 2.2 | `kettő egész kettő tized` | `két egész két tized` |
| Italian (`it`) | 108, 180 | `centootto`, `centoottanta` | `centotto`, `centottanta` |
| Italian (`it`) | 21,000,000 | `ventuno milioni` | `ventun milioni` |
| Kazakh (`kk`) | 100, 1000 | `бір жүз`, `бір мың` | `жүз`, `мың` |
| Armenian (`hy`) | 1000 | `մեկ հազար` | `հազար` |
| Lithuanian (`lt`) | 10⁹, 10¹² | `bilijonas`, `trilijonas` | `milijardas`, `trilijonas` |
| Latvian (`lv`) | 100, 133 | `viens simts`, `viens simts trīsdesmit trīs` | `simts`, `simt trīsdesmit trīs` |
| Russian (`ru`) | 2 × 10²⁴ | `два секстиллиона` | `два септиллиона` |
| Spanish (`es`) | 901, feminine and apocopated | `novecientas un` | `novecientas una` |
| Spanish (`es`) | 25, apocopated | `veintiún` | `veinticinco` |
| Brazilian Portuguese (`pt-BR`) | 2,000,000, feminine | `duas milhões` | `dois milhões` |
| Vietnamese (`vi`) | 18 | `thứ mười tám` | `mười tám` |

* **Danish:** The number 1 is the counting form `en`; `gender: :neuter` gives `et`.
* **Hungarian:** The form `két` replaces `kettő` before hundreds and scale words (`huszonkétezer`), but not at the end (`huszonkettő`).
* **Spanish:** The `apocopated: true` option shortens only the masculine `uno`, and only a final one (`veintiún`, not `veinticinco`).
* **Czech:** Without `gender`, numbers use the counting forms (`jedna`, `dva`); pass `gender: :female` for the previous `dvě`.

See [#289](https://github.com/kslazarev/numbers_and_words/pull/289) for details.

#### Portuguese Uses European Forms and the Long Scale

Portuguese (`pt`) is the language of Portugal, and 1.0 mixed Brazilian forms into it. It now uses the European Portuguese forms of the [Acordo Ortográfico](https://en.wikipedia.org/wiki/Portuguese_Language_Orthographic_Agreement_of_1990) and the long scale, as in Portugal. It joins scale words with `e`, as Brazilian Portuguese does. Brazilian Portuguese (`pt-BR`) is unchanged; use it for the Brazilian forms.

| Number | 1.0.x | 1.1.0 |
| --- | --- | --- |
| 14, 16, 17, 19 | `quatorze`, `dezesseis`, `dezessete`, `dezenove` | `catorze`, `dezasseis`, `dezassete`, `dezanove` |
| 1000, 1030 | `um mil`, `um mil trinta` | `mil`, `mil e trinta` |
| 1,000,100 | `um milhão cem` | `um milhão e cem` |
| 10⁹, 2 × 10⁹ | `um bilhão`, `dois bilhões` | `mil milhões`, `dois mil milhões` |
| 10¹², 10¹⁵, 10¹⁸ | `um trilhão`, `um quadrilhão`, `um quinquilhão` | `um bilião`, `mil biliões`, `um trilião` |
| 10⁹, ordinal | `bilionésimo` | `milésimo milionésimo` |
| 10⁻⁹, `fraction: true` | `um bilionésimo` | `um milésimo de milionésimo` |

#### Brazilian Portuguese Ordinals Past the Last Scale Word

Brazilian Portuguese ordinals of 10³⁶ and more raise `RangeError`, as their cardinals do, instead of being spelled without their highest digits (`zero` for 10³⁶).

#### Czech Ordinals of Thousands

Czech ordinals from 1,000 to 9,999 start with one word for the thousands (`tisící`, `dvoutisící`). From 10,000 they raise `RangeError` instead of returning wrong words.

```ruby
I18n.with_locale(:cs) { 1984.to_words(ordinal: true, gender: :male) }
# 1.0.x => "první tisíc devítistý osmdesátý čtvrtý"
# 1.1.0 => "tisící devítistý osmdesátý čtvrtý"
```

#### Negative Numbers Are Read with a Minus Word

Negative numbers used to lose their sign, or read as a garbled number in some languages. They now start with the language's word for minus, with no space after it in Chinese, Japanese and Thai. Ordinals of negative numbers raise `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError`.

```ruby
I18n.with_locale(:en) { -5.to_words }
# 1.0.x => "five"
# 1.1.0 => "minus five"

I18n.with_locale(:vi) { -42.to_words }
# 1.0.x => "không trăm bốn mươi hai"
# 1.1.0 => "âm bốn mươi hai"
```

To keep the old output, convert the absolute value, `number.abs.to_words`.

#### Out-of-Range Numbers and Unsupported Decimals Raise Errors

Numbers beyond a language's largest scale word used to print a bare multiplier ("en " in Danish for 10<sup>21</sup>, "un" in Spanish for 10<sup>48</sup>). They now raise `RangeError`; each language page gives its limit. Decimals in a language without decimals used to raise `NameError`, and now raise `NumbersAndWords::UnsupportedNumberError` ("decimals are not supported in :da").

Russian, Ukrainian and Czech decimals with more fractional digits than their fraction words name (23) also raise `RangeError` ("decimals support up to 23 fractional digits in :ru"). With 16 to 23 digits, such as `0.1 + 0.2`, they used to end in a bare prefix ("ноль целых и тридцать квадриллионов четыре сто"). They now end in their fraction word ("... четыре стоквадриллионных").

#### Decimals Keep the Cardinal Form With `ordinal: true`

The `ordinal: true` option used to turn parts of a decimal into ordinals in some languages. It now applies to whole numbers only. A float, including one such as `2.0`, keeps its cardinal reading in every language.

```ruby
I18n.with_locale(:en) { 1.5.to_words(ordinal: true) }
# 1.0.x => "first and fifth tenths"
# 1.1.0 => "one and five tenths"

I18n.with_locale(:cs) { 1.5.to_words(ordinal: true) }
# 1.0.x => "první celých pátá desetin"
# 1.1.0 => "jedna celá pět desetin"
```

To get an ordinal, convert an integer, `1.5.to_i.to_words(ordinal: true)`.
