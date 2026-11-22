# Upgrading

## Upgrading to 1.2.0

### Error and Warning Messages Are Sentences

Error and warning messages start with a capital letter and end with a period, and the four ordinal range errors share one message. The error classes don't change; rescue them rather than matching messages.

| 1.1.0 | 1.2.0 |
| --- | --- |
| `numbers must be below 10**30 in :cs` | `Numbers in :cs only support values below 10**30.` |
| `decimals are not supported in :sv` | `Decimals are not supported in :sv.` |
| `Arabic ordinals support 1 to 99` | `Ordinals in :ar only support numbers between 1 and 99.` |
| `unsupported option :gender for locale :vi; supported: ...` | `The option :gender is not supported in :vi; supported: ....` |

### Languages Declare Their Options in Their Locale Files

Each language lists the options it accepts under `numbers.supported_options` in its locale file, and spells whole numbers from the rule sets under `numbers.rules`. Applications can change both through I18n like any other translation. The option classes under `NumbersAndWords::Strategies::FiguresConverter::Options`, other than `Option` and the Polish `Gender`, are gone.

## Upgrading to 1.1.0

1.1.0 keeps the 1.0 behavior that callers may rely on, warns about what 2.0 will change, and fixes wrong output. To choose a default that 2.0 changes, and silence its warning, pass the option explicitly; this works in 1.1 and 2.0 alike. To raise for unsupported options now, as 2.0 will, set `strict_options`.

```ruby
NumbersAndWords.config.strict_options = true
```

Each warning is shown once per process. Warnings about changed defaults are deprecation warnings, which Ruby shows only with `Warning[:deprecated] = true` or `ruby -W:deprecated`; the others are always shown.

### Deprecated: Unsupported Options Are Ignored

`to_words` used to ignore options a language doesn't support, and an invalid value could return garbage. Each language accepts the global options (`precision`, `micro_separator`, `fallback`, `unit`, `subunit` and `zero_subunit`) and the options on its [language page](docs/languages). 1.1.0 ignores anything else with a warning, and 2.0 will raise `NumbersAndWords::UnsupportedOptionError`, an `ArgumentError`, as 1.1.0 does with `NumbersAndWords.config.strict_options = true`.

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

English, French, Swiss French, Italian and Portuguese read decimals as a fraction by default, as in 1.0. `fraction: false` reads them with a decimal point, as British English does, and 2.0 will make it the default. English reads each digit after the point; Brazilian Portuguese reads up to six decimal places as a number (`três vírgula mil quatrocentos e dezesseis`); the others read up to three decimal places as a number and longer ones digit by digit.

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

To keep the fraction reading in 2.0, pass `fraction: true`, which British English accepts too. With `remove_zero: true`, `0.7` is `seven tenths`, or `point seven` with `fraction: false`. Amounts with a [`unit`](README.md#unit) read decimals with a decimal point in every version. See [#289](https://github.com/kslazarev/numbers_and_words/pull/289).

### Deprecated: French Uses the Traditional Spelling by Default

French (`fr`) and Swiss French (`fr-CH`) use the traditional spelling by default, as in 1.0. `spelling: :reformed` follows the 1990 spelling reform, hyphenating every numeral in a compound number except the nouns `million`, `milliard` and larger, and 2.0 will make it the default.

```ruby
I18n.with_locale(:fr) { 321.to_words }
# 1.0.x, 1.1.0 => "trois cent vingt et un"
# 2.0.0 => "trois-cent-vingt-et-un"

I18n.with_locale(:fr) { 2_000_021.to_words(spelling: :reformed) }
# => "deux millions vingt-et-un"
```

To keep the traditional spelling in 2.0, pass `spelling: :traditional`. See [#257](https://github.com/kslazarev/numbers_and_words/pull/257) and [#264](https://github.com/kslazarev/numbers_and_words/issues/264).

### Deprecated: British English Omits "and" After Hundreds by Default

British English (`en-GB`) omits "and" by default, as in 1.0. `hundreds_with_union: true` adds it after hundreds, and before a final part below one hundred after thousand, million or a larger scale, and 2.0 will make it the default. American English (`en`) won't change.

```ruby
I18n.with_locale(:'en-GB') { 101.to_words }
# 1.0.x, 1.1.0 => "one hundred one"
# 2.0.0 => "one hundred and one"

I18n.with_locale(:'en-GB') { 1001.to_words(hundreds_with_union: true) }
# => "one thousand and one"
```

To keep the 1.0 output in 2.0, pass `hundreds_with_union: false`. See [#251](https://github.com/kslazarev/numbers_and_words/pull/251).

### Deprecated: Swedish, Ukrainian and Kazakh Locale Codes

Three languages used non-standard codes: `se` is Northern Sami, and `ua` and `kz` are country codes. The gem now uses the ISO 639-1 codes, regional variants such as `sv-SE` included. The old codes still convert, with a warning, and 2.0 will raise `NumbersAndWords::UnsupportedLanguageError` for them.

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

Replace the old codes in `I18n` locales, `NumbersAndWords.config.locales` and `fallback:`. The gem's locale files are now `numbers.sv.yml`, `numbers.uk.yml` and `numbers.kk.yml` and are looked up under the new codes, so move application overrides of the gem's `numbers.*` translations from `se`, `ua` and `kz` to `sv`, `uk` and `kk` now. See [#300](https://github.com/kslazarev/numbers_and_words/pull/300).

### Unsupported Languages Raise `NumbersAndWords::UnsupportedLanguageError`

Unsupported or disabled locales raise `NumbersAndWords::UnsupportedLanguageError`, a `RuntimeError` as before, with the same messages, so `rescue RuntimeError` still works and the error can now be rescued by name. See [#293](https://github.com/kslazarev/numbers_and_words/pull/293).

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

Several languages now use the usual forms, as reviewed in [#255](https://github.com/kslazarev/numbers_and_words/issues/255). The previous forms can't be restored.

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

- **Danish:** 1 is the counting form `en`; `gender: :neuter` gives `et`.
- **Hungarian:** `két` replaces `kettő` before hundreds and scale words (`huszonkétezer`), but not at the end (`huszonkettő`).
- **Spanish:** `apocopated: true` shortens only the masculine `uno`, and only a final one (`veintiún`, not `veinticinco`).
- **Czech:** without `gender`, numbers use the counting forms (`jedna`, `dva`); pass `gender: :female` for the previous `dvě`.

See [#289](https://github.com/kslazarev/numbers_and_words/pull/289) for details.

#### Portuguese Uses European Forms and the Long Scale

Portuguese (`pt`) is the language of Portugal, and 1.0 mixed Brazilian forms into it. It now uses the European Portuguese forms of the [Acordo Ortográfico](https://en.wikipedia.org/wiki/Portuguese_Language_Orthographic_Agreement_of_1990) and the long scale, as in Portugal, and joins scale words with `e` as Brazilian Portuguese does. Brazilian Portuguese (`pt-BR`) is unchanged; use it for the Brazilian forms. This is a fix and can't be turned off in `pt`; use `pt-BR` for the Brazilian forms.

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

Czech ordinals from 1,000 to 9,999 start with one word for the thousands (`tisící`, `dvoutisící`); from 10,000 they raise `RangeError` instead of returning wrong words.

```ruby
I18n.with_locale(:cs) { 1984.to_words(ordinal: true, gender: :male) }
# 1.0.x => "první tisíc devítistý osmdesátý čtvrtý"
# 1.1.0 => "tisící devítistý osmdesátý čtvrtý"
```

#### Negative Numbers Are Read With a Minus Word

Negative numbers used to lose their sign, or read as a garbled number in some languages. They now start with the language's word for minus, joined without a space in Chinese, Japanese and Thai. Ordinals of negative numbers raise `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError`.

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

Numbers beyond a language's largest scale word used to print a bare multiplier ("en " in Danish for 10<sup>21</sup>, "un" in Spanish for 10<sup>48</sup>) and now raise `RangeError`; each language page gives its limit. Decimals in a language without decimals used to raise `NameError` and now raise `NumbersAndWords::UnsupportedNumberError` ("decimals are not supported in :da").

Russian, Ukrainian and Czech decimals with more fractional digits than their fraction words name (23) also raise `RangeError` ("decimals support up to 23 fractional digits in :ru"); with 16 to 23 digits, such as `0.1 + 0.2`, they used to end in a bare prefix ("ноль целых и тридцать квадриллионов четыре сто") and now end in their fraction word ("... четыре стоквадриллионных").

#### Decimals Keep the Cardinal Form With `ordinal: true`

`ordinal: true` used to turn parts of a decimal into ordinals in some languages and now applies to whole numbers only; a float, including one such as `2.0`, keeps its cardinal reading in every language.

```ruby
I18n.with_locale(:en) { 1.5.to_words(ordinal: true) }
# 1.0.x => "first and fifth tenths"
# 1.1.0 => "one and five tenths"

I18n.with_locale(:cs) { 1.5.to_words(ordinal: true) }
# 1.0.x => "první celých pátá desetin"
# 1.1.0 => "jedna celá pět desetin"
```

To get an ordinal, convert an integer, `1.5.to_i.to_words(ordinal: true)`.
