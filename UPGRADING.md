# Upgrading

## Upgrading to 2.0.0

### Unsupported Options Raise an Error

`to_words` used to ignore options a language doesn't support, and invalid values could return garbage. Each language now accepts only the global options (`precision`, `micro_separator`, `fallback`, `unit`, `subunit` and `zero_subunit`) and the options on its [language page](docs/languages). Anything else raises `NumbersAndWords::UnsupportedOptionError`, an `ArgumentError`.

```ruby
I18n.with_locale(:vi) { 21.to_words(gender: :female) }
# 1.0.x => "hai mươi mốt"
# 2.0.0 => NumbersAndWords::UnsupportedOptionError: unsupported option :gender for locale :vi; supported: :micro_separator, :ordinal, :precision, :remove_zero, :subunit, :unit, :zero_subunit

I18n.with_locale(:es) { 1.to_words(gender: :neuter) }
# 1.0.x => "r"
# 2.0.0 => NumbersAndWords::UnsupportedOptionError: unsupported value :neuter for option :gender in locale :es; supported: :male, :female
```

Pass each option only to the locales that accept it. Flags such as `ordinal` accept only `true` or `false`.

See [#269](https://github.com/kslazarev/numbers_and_words/pull/269) and [#266](https://github.com/kslazarev/numbers_and_words/issues/266) for details.

### British English Says "and" After Hundreds

British English (`en-GB`) now adds "and" after hundreds, and before a final part below one hundred after thousand, million or a larger scale, by default. American English (`en`) is unchanged.

```ruby
I18n.with_locale(:'en-GB') { 101.to_words }
# 1.0.x => "one hundred one"
# 2.0.0 => "one hundred and one"

I18n.with_locale(:'en-GB') { 1001.to_words }
# 1.0.x => "one thousand one"
# 2.0.0 => "one thousand and one"
```

To keep the previous output, pass `hundreds_with_union: false`:

```ruby
I18n.with_locale(:'en-GB') { 101.to_words(hundreds_with_union: false) }
# => "one hundred one"
```

See [#251](https://github.com/kslazarev/numbers_and_words/pull/251) for details.

### French Uses the 1990 Spelling Reform

French (`fr`) and Swiss French (`fr-CH`) now follow the 1990 spelling reform, hyphenating every numeral in a compound number except the nouns `million`, `milliard` and larger.

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

Several languages now use the usual forms, as reviewed in [#255](https://github.com/kslazarev/numbers_and_words/issues/255). The previous forms can't be restored.

| Language | Number | 1.0.x | 2.0.0 |
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

### Portuguese Uses European Forms and the Long Scale

Portuguese (`pt`) now uses the European Portuguese forms of the [Acordo Ortográfico](https://en.wikipedia.org/wiki/Portuguese_Language_Orthographic_Agreement_of_1990) and the long scale, as in Portugal, and joins scale words with `e` as Brazilian Portuguese does. Brazilian Portuguese (`pt-BR`) is unchanged; use it for the Brazilian forms. The previous forms can't be restored in `pt`.

| Number | 1.0.x | 2.0.0 |
| --- | --- | --- |
| 14, 16, 17, 19 | `quatorze`, `dezesseis`, `dezessete`, `dezenove` | `catorze`, `dezasseis`, `dezassete`, `dezanove` |
| 1000, 1030 | `um mil`, `um mil trinta` | `mil`, `mil e trinta` |
| 1,000,100 | `um milhão cem` | `um milhão e cem` |
| 10⁹, 2 × 10⁹ | `um bilhão`, `dois bilhões` | `mil milhões`, `dois mil milhões` |
| 10¹², 10¹⁵, 10¹⁸ | `um trilhão`, `um quadrilhão`, `um quinquilhão` | `um bilião`, `mil biliões`, `um trilião` |
| 10⁹, ordinal | `bilionésimo` | `milésimo milionésimo` |
| 10⁻⁹, `fraction: true` | `um bilionésimo` | `um milésimo de milionésimo` |

### Decimals Are Read With a Decimal Point

English, French, Swiss French, Italian and Portuguese now read decimals with a decimal point, as British English did, rather than as a fraction. English reads each digit; Brazilian Portuguese reads up to six decimal places as a number (`três vírgula mil quatrocentos e dezesseis`); the others read up to three decimal places as a number and longer ones digit by digit.

| Language | Number | 1.0.x | 2.0.0 |
| --- | --- | --- | --- |
| English (`en`) | 21.77 | `twenty-one and seventy-seven hundredths` | `twenty-one point seven seven` |
| French (`fr`) | 3.05 | `trois et cinq centièmes` | `trois virgule zéro cinq` |
| Italian (`it`) | 21.77 | `ventuno e settantasette centesimi` | `ventuno virgola settantasette` |
| Portuguese (`pt`, `pt-BR`) | 21.77 | `vinte e um inteiros e setenta e sete centésimos` | `vinte e um vírgula setenta e sete` |

To keep the fraction reading, pass `fraction: true`, which British English accepts too.

```ruby
I18n.with_locale(:en) { 21.77.to_words(fraction: true) }
# => "twenty-one and seventy-seven hundredths"
```

With `remove_zero: true`, `0.7` is `point seven`, or `seven tenths` with `fraction: true`.

### Czech Ordinals of Thousands

Czech ordinals from 1,000 to 9,999 start with one word for the thousands (`tisící`, `dvoutisící`); from 10,000 they raise `RangeError` instead of returning wrong words.

```ruby
I18n.with_locale(:cs) { 1984.to_words(ordinal: true, gender: :male) }
# 1.0.x => "první tisíc devítistý osmdesátý čtvrtý"
# 2.0.0 => "tisící devítistý osmdesátý čtvrtý"
```

### Unsupported Languages Raise `NumbersAndWords::UnsupportedLanguageError`

Unsupported or disabled locales raise `NumbersAndWords::UnsupportedLanguageError`, a `StandardError`, with the same messages as before. In 1.0.x they were `RuntimeError`s, so replace `rescue RuntimeError` with `rescue NumbersAndWords::UnsupportedLanguageError`.

```ruby
begin
  I18n.with_locale(:am) { 42.to_words }
rescue NumbersAndWords::UnsupportedLanguageError => e
  e.message # => "Language not supported"
end
```

See [#293](https://github.com/kslazarev/numbers_and_words/pull/293) for details.

### Negative Numbers Are Read With a Minus Word

Negative numbers used to lose their sign, or read as a garbled number in some languages. They now start with the language's word for minus, joined without a space in Chinese, Japanese and Thai. Ordinals of negative numbers raise `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError`.

```ruby
I18n.with_locale(:en) { -5.to_words }
# 1.0.x => "five"
# 2.0.0 => "minus five"

I18n.with_locale(:vi) { -42.to_words }
# 1.0.x => "không trăm bốn mươi hai"
# 2.0.0 => "âm bốn mươi hai"
```

To keep the old output, convert the absolute value, `number.abs.to_words`.

### Out-of-Range Numbers and Unsupported Decimals Raise Errors

Numbers beyond a language's largest scale word used to print a bare multiplier ("en " in Danish for 10<sup>21</sup>, "un" in Spanish for 10<sup>48</sup>) and now raise `RangeError`; each language page gives its limit. Decimals in a language without decimals used to raise `NameError` and now raise `NumbersAndWords::UnsupportedNumberError` ("decimals are not supported in :da").

Russian, Ukrainian and Czech decimals with more fractional digits than their fraction words name (23) also raise `RangeError` ("decimals support up to 23 fractional digits in :ru"); with 16 to 23 digits, such as `0.1 + 0.2`, they used to end in a bare prefix ("ноль целых и тридцать квадриллионов четыре сто") and now end in their fraction word ("... четыре стоквадриллионных").

### Decimals Keep the Cardinal Form With `ordinal: true`

`ordinal: true` used to turn parts of a decimal into ordinals in some languages and now applies to whole numbers only; a float, including one such as `2.0`, keeps its cardinal reading in every language.

```ruby
I18n.with_locale(:en) { 1.5.to_words(ordinal: true) }
# 1.0.x => "first and fifth tenths"
# 2.0.0 => "one point five"

I18n.with_locale(:cs) { 1.5.to_words(ordinal: true) }
# 1.0.x => "první celých pátá desetin"
# 2.0.0 => "jedna celá pět desetin"
```

To get an ordinal, convert an integer, `1.5.to_i.to_words(ordinal: true)`.

### Further Language Corrections

These corrections replace output from earlier 2.0.0 development revisions. No option restores the incorrect forms.

| Language | Number and Options | Previous Output | Corrected Output |
| --- | --- | --- | --- |
| Armenian (`hy`) | 10¹⁵ | `մեկ քառակուսի` | `մեկ կվադրիլիոն` |
| Armenian (`hy`) | 10¹⁵, `ordinal: true` | `քառակուսիերորդ` | `կվադրիլիոներորդ` |
| Bulgarian (`bg`) | 2,000, `ordinal: true` | `двухиляден` | `двехиляден` |
| Czech (`cs`) | 0.1 | `nula celých jedna desetina` | `nula celá jedna desetina` |
| Slovak (`sk`) | 0.1 | `nula celá jedna desatina` | `nula celých jedna desatina` |
| Danish (`da`) | 2, `ordinal: true, gender: :neuter` | `anden` | `andet` |
| German (`de`) | 2,002,000,000, `ordinal: true` | `zwei Milliarden zweimillionste` | `zweimilliardenzweimillionste` |
| Spanish (`es`) | 22,000, `ordinal: true` | `veintidósmilésimo` | `veintidosmilésimo` |
| Spanish (`es`) | 32,000, `ordinal: true` | `treintaydosmilésimo` | `treintaidosmilésimo` |
| Spanish (`es`) | 21,000, `ordinal: true, gender: :female` | `veintiunamilésima` | `veintiunmilésima` |
| Russian (`ru`) | 90,000, `ordinal: true` | `девяностатысячный` | `девяностотысячный` |

### Swedish, Ukrainian and Kazakh Use Standard Locale Codes

Three languages used non-standard codes: `se` is Northern Sami, and `ua` and `kz` are country codes. They now use the ISO 639-1 codes, regional variants such as `sv-SE` included, and the old codes raise `NumbersAndWords::UnsupportedLanguageError`.

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

Replace the old codes in `I18n` locales, `NumbersAndWords.config.locales`, `fallback:`, and any overrides of the gem's locale files, which are now `numbers.sv.yml`, `numbers.uk.yml` and `numbers.kk.yml`.

See [#300](https://github.com/kslazarev/numbers_and_words/pull/300) for details.
