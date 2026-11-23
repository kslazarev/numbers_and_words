<img src="assets/logo.svg" alt="A red 42 tile speaking through a speech bubble that holds the Ruby string &quot;forty-two&quot;, followed by .to_words." width="160">

# numbers_and_words

[![Gem Version](https://badge.fury.io/rb/numbers_and_words.svg)](https://badge.fury.io/rb/numbers_and_words)
[![Test](https://github.com/kslazarev/numbers_and_words/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/kslazarev/numbers_and_words/actions/workflows/test.yml)
[![Lint](https://github.com/kslazarev/numbers_and_words/actions/workflows/lint.yml/badge.svg?branch=master)](https://github.com/kslazarev/numbers_and_words/actions/workflows/lint.yml)
[![Package](https://github.com/kslazarev/numbers_and_words/actions/workflows/package.yml/badge.svg?branch=master)](https://github.com/kslazarev/numbers_and_words/actions/workflows/package.yml)
[![Coverage Status](https://coveralls.io/repos/github/kslazarev/numbers_and_words/badge.svg?branch=master)](https://coveralls.io/github/kslazarev/numbers_and_words?branch=master)

Spell out numbers in several languages using the I18n gem.

Перевод чисел в слова при помощи библиотеки I18n.

Convertit les nombres en lettres en utilisant la librairie I18n.

Számok betűvel írva az I18n könyvtár segítségével.

I18n kütüphanesi ile sayıları yazıya çevirir.

Soletra números em vários idiomas utilizando a biblioteca I18n.

Deletrea números en varios idiomas utilizando la gema I18n.

## Installation / Установка / Installation

```
gem install numbers_and_words
```

Or add it to your Gemfile:

```ruby
gem 'numbers_and_words'
```

## Usage / Использование / Utilisation

Call `to_words` on an integer, a float or an array in the locale of your choice.

```ruby
require 'numbers_and_words'

I18n.with_locale(:en) { 42.to_words }
# => "forty-two"

I18n.with_locale(:es) { 42.to_words }
# => "cuarenta y dos"

I18n.with_locale(:ru) { 42.to_words }
# => "сорок два"

I18n.with_locale(:fr) { 42.to_words }
# => "quarante-deux"

I18n.with_locale(:de) { 42.to_words }
# => "zweiundvierzig"

I18n.with_locale(:en) { [1, 2, 3].to_words }
# => ["one", "two", "three"]

I18n.with_locale(:en) { 21.77.to_words }
# => "twenty-one and seventy-seven hundredths"
```

Floats in scientific notation, such as `0.00001` (`1.0e-05`), are read from their exact decimal value.

```ruby
I18n.with_locale(:en) { 0.00001.to_words }
# => "zero and one hundred-thousandth"
```

Negative numbers start with the word for minus. They have no ordinal: `ordinal: true` raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError`. Numbers past a language's largest scale word raise `RangeError`. Each language page gives its limit.

```ruby
I18n.with_locale(:en) { -42.to_words }
# => "minus forty-two"

I18n.with_locale(:fr) { -1.5.to_words }
# => "moins un et cinq dixièmes"
```

### Command Line

The `to_words` command spells each argument, or each number on standard input, one per line.

```
$ to_words 42 1.5
forty-two
one and five tenths

$ to_words --locale ru 2000
две тысячи

$ echo 21 | to_words --ordinal
twenty-first

$ to_words --locale es --gender female 21
veintiuna
```

Choose the language with `-l`/`--locale` (default `en`). Every option has a flag, such as `--ordinal` (and `--no-ordinal`), `--gender VALUE` or `--precision N`. `to_words --help` lists the flags and the languages that support each. Errors go to standard error, with exit status 1.

## Supported Languages / Языки / Langues Supportées

Each language page has examples, says whether it reads decimals, and documents its options. [Features](docs/features.md) compares the languages.

| Language | Name | Code |
| --- | --- | --- |
| [Afrikaans](docs/languages/af.md)* | Afrikaans | `af` |
| [Albanian](docs/languages/sq.md)* | Shqip | `sq` |
| [Arabic](docs/languages/ar.md)* | العربية | `ar` |
| [Armenian](docs/languages/hy.md) | Հայերեն | `hy` |
| [Azerbaijani](docs/languages/az.md)* | Azərbaycan dili | `az` |
| [Belarusian](docs/languages/be.md)* | Беларуская | `be` |
| [Bengali](docs/languages/bn.md)* | বাংলা | `bn` |
| [Brazilian Portuguese](docs/languages/pt-BR.md) | Português brasileiro | `pt-BR` |
| [British English](docs/languages/en-GB.md) | English (British) | `en-GB` |
| [Bosnian](docs/languages/bs.md)* | Bosanski | `bs` |
| [Bulgarian](docs/languages/bg.md)* | Български | `bg` |
| [Catalan](docs/languages/ca.md)* | Català | `ca` |
| [Burmese](docs/languages/my.md)* | မြန်မာဘာသာ | `my` |
| [Chinese](docs/languages/zh.md)* | 中文 | `zh` |
| [Croatian](docs/languages/hr.md)* | Hrvatski | `hr` |
| [Czech](docs/languages/cs.md) | Čeština | `cs` |
| [Danish](docs/languages/da.md) | Dansk | `da` |
| [Dutch](docs/languages/nl.md) | Nederlands | `nl` |
| [English](docs/languages/en.md) | English | `en` |
| [Esperanto](docs/languages/eo.md)* | Esperanto | `eo` |
| [Estonian](docs/languages/et.md) | Eesti | `et` |
| [Filipino](docs/languages/fil.md)* | Filipino | `fil` |
| [Finnish](docs/languages/fi.md)* | Suomi | `fi` |
| [French](docs/languages/fr.md) | Français | `fr` |
| [Georgian](docs/languages/ka.md) | ქართული | `ka` |
| [German](docs/languages/de.md) | Deutsch | `de` |
| [Greek](docs/languages/el.md)* | Ελληνικά | `el` |
| [Hebrew](docs/languages/he.md)* | עברית | `he` |
| [Hindi](docs/languages/hi.md)* | हिन्दी | `hi` |
| [Hungarian](docs/languages/hu.md) | Magyar | `hu` |
| [Icelandic](docs/languages/is.md)* | Íslenska | `is` |
| [Indonesian](docs/languages/id.md) | Bahasa Indonesia | `id` |
| [Irish](docs/languages/ga.md)* | Gaeilge | `ga` |
| [Italian](docs/languages/it.md) | Italiano | `it` |
| [Japanese](docs/languages/ja.md)* | 日本語 | `ja` |
| [Kazakh](docs/languages/kk.md) | Қазақша | `kk` |
| [Khmer](docs/languages/km.md)* | ភាសាខ្មែរ | `km` |
| [Korean](docs/languages/ko.md)* | 한국어 | `ko` |
| [Lao](docs/languages/lo.md)* | ພາສາລາວ | `lo` |
| [Latvian](docs/languages/lv.md) | Latviešu | `lv` |
| [Lithuanian](docs/languages/lt.md) | Lietuvių | `lt` |
| [Macedonian](docs/languages/mk.md)* | Македонски | `mk` |
| [Malay](docs/languages/ms.md)* | Bahasa Melayu | `ms` |
| [Maltese](docs/languages/mt.md)* | Malti | `mt` |
| [Norwegian Bokmål](docs/languages/nb.md)* | Norsk bokmål | `nb` |
| [Persian](docs/languages/fa.md)* | فارسی | `fa` |
| [Polish](docs/languages/pl.md)* | Polski | `pl` |
| [Portuguese](docs/languages/pt.md) | Português | `pt` |
| [Romanian](docs/languages/ro.md)* | Română | `ro` |
| [Russian](docs/languages/ru.md) | Русский | `ru` |
| [Serbian](docs/languages/sr.md)* | Српски | `sr` |
| [Slovak](docs/languages/sk.md)* | Slovenčina | `sk` |
| [Slovenian](docs/languages/sl.md)* | Slovenščina | `sl` |
| [Spanish](docs/languages/es.md) | Español | `es` |
| [Swahili](docs/languages/sw.md)* | Kiswahili | `sw` |
| [Swedish](docs/languages/sv.md)* | Svenska | `sv` |
| [Swiss French](docs/languages/fr-CH.md) | Français (Suisse) | `fr-CH` |
| [Tamil](docs/languages/ta.md)* | தமிழ் | `ta` |
| [Thai](docs/languages/th.md)* | ภาษาไทย | `th` |
| [Turkish](docs/languages/tr.md) | Türkçe | `tr` |
| [Ukrainian](docs/languages/uk.md) | Українська | `uk` |
| [Urdu](docs/languages/ur.md)* | اردو | `ur` |
| [Vietnamese](docs/languages/vi.md) | Tiếng Việt | `vi` |
| [Welsh](docs/languages/cy.md)* | Cymraeg | `cy` |

\* Experimental: known gaps or no native-speaker review yet, as its page explains. To help, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Regional locales use their language: `en-AU`, `en-CA`, `en-IN` and `en-US` use `en`; `fr-CA` uses `fr`; `de-AT` and `de-CH` use `de`; `it-CH` uses `it`; `nb-NO`, `no` and `no-NO` use `nb`; `zh-CN` and `zh-SG` use `zh`.

## Options / Опции / Options

Pass options to `to_words`. The options below work in every language. Language options, such as `gender`, `ordinal` or `remove_zero`, are on each language page.

### Precision

`precision` pads the fractional part of a float with zeros.

```ruby
I18n.with_locale(:ru) { 0.1.to_words(precision: 3) }
# => "ноль целых и сто тысячных"

I18n.with_locale(:es) { 0.2.to_words(precision: 2) }
# => "cero con veinte centésimas"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a float.

```ruby
I18n.with_locale(:en) { 21.77.to_words(micro_separator: "plus") }
# => "twenty-one plus seventy-seven hundredths"
```

### Fallback

A locale with no bundled rules, or one the configuration disables, raises `NumbersAndWords::UnsupportedLanguageError`. Set `fallback` to a bundled locale to convert in that locale instead, or to `true` to return the digits.

```ruby
I18n.with_locale(:am) { 42.to_words(fallback: :fr) }
# => "quarante-deux"

I18n.with_locale(:am) { 42.to_words(fallback: true) }
# => "42"
```

Other options are validated for the fallback locale. A locale missing from `I18n.available_locales` never reaches the gem: `I18n.with_locale` raises `I18n::InvalidLocale` first. To set a fallback for every call, see [Configuration](#configuration--конфигурация).

### Unit

`unit` follows a number with a unit word, such as a currency, in the form the number calls for. The gem ships no units: `unit: :ruble` looks up `units.ruble` in your application's translations, and `"money.ruble"` looks up `units.money.ruble`. A unit has one form per plural category of the language, such as `one`, `few`, `many` and `other` in Russian and Ukrainian, or `one` and `other` in English. A unit that never changes is one string. An optional `gender` sets the number's gender in languages with a `gender` option. A `gender` passed to `to_words` overrides it.

```yaml
en:
  units:
    dollar: { one: dollar, other: dollars }
    cent: { one: cent, other: cents }
fr:
  units:
    euro: { one: euro, other: euros }
    centime: { one: centime, other: centimes }
ru:
  units:
    ruble: { one: рубль, few: рубля, many: рублей, other: рубля, gender: male }
    kopeck: { one: копейка, few: копейки, many: копеек, other: копейки, gender: female }
zh:
  units:
    yuan: 元
he:
  units:
    shekel: { one: שקל, other: שקלים, gender: male }
    agora: { one: אגורה, other: אגורות, gender: female }
ar:
  units:
    dinar: { zero: دينار, one: دينار, two: ديناران, few: دنانير, many: دينارًا, other: دينار }
    fils: { one: فلس, two: فلسان, few: فلوس, many: فلسًا, other: فلس }
```

With these translations:

```ruby
I18n.with_locale(:en) { 1.to_words(unit: :dollar) }
# => "one dollar"

I18n.with_locale(:en) { 21.to_words(unit: :dollar) }
# => "twenty-one dollars"

I18n.with_locale(:ru) { 21.to_words(unit: :ruble) }
# => "двадцать один рубль"

I18n.with_locale(:ru) { 22.to_words(unit: :kopeck) }
# => "двадцать две копейки"

I18n.with_locale(:ru) { 11.to_words(unit: :kopeck) }
# => "одиннадцать копеек"

I18n.with_locale(:ru) { [1, 5].to_words(unit: :ruble) }
# => ["один рубль", "пять рублей"]

I18n.with_locale(:zh) { 21.to_words(unit: :yuan) }
# => "二十一元"
```

The unit follows the number after a space, or with no space in Chinese, Japanese and Thai. Hebrew and Arabic put one after its unit, and Arabic says two with the dual form alone, as their pages describe. Before a unit, a number takes the form it has before a noun, listed under `numbers.before_unit` in the locale file. Examples are German "ein Euro" and "eine Mark", Swedish "en krona", Italian "un euro", Romanian "un leu" and "o liră", Hungarian "két forint" and Spanish "un euro" (see `apocopated` on its page). The unit's `gender` picks between these forms. With `ordinal: true` the unit is singular, since an ordinal names one item: the twenty-first dollar. Decimals keep their cardinal form.

```ruby
I18n.with_locale(:en) { 21.to_words(unit: :dollar, ordinal: true) }
# => "twenty-first dollar"

I18n.with_locale(:ru) { 22.to_words(unit: :kopeck, ordinal: true) }
# => "двадцать вторая копейка"
```

A unit without a translation, or missing both the form a number needs and the `other` form, raises `NumbersAndWords::UnsupportedOptionError`, such as `The unit :euro has no translation in :ru, expected at units.euro.`. Unit forms are nominative, so `unit` with another `case` raises too.

In Spanish, French, Italian and Portuguese, a whole number that ends in a scale word of a million or more takes `de` (Italian `di`) before the unit. One that ends in another word, such as `mil`, doesn't. French shortens `de` to `d'` before a vowel. A unit sets `elision: true` for a mute h (`d'hectares`), or `elision: false` for another exception. Romanian puts `de` in the unit forms, as it does for any number from 20.

```ruby
I18n.with_locale(:fr) { 2_000_000.to_words(unit: :euro) }
# => "deux millions d'euros"
```

After a decimal, the unit takes its `other` form, which is the genitive singular in Russian and Czech. French and Portuguese use the singular below 2, and Romanian uses the `few` form. A float with no fractional part reads as a whole number.

```ruby
I18n.with_locale(:en) { 1.5.to_words(unit: :dollar) }
# => "one point five dollars"

I18n.with_locale(:ru) { 1.5.to_words(unit: :ruble) }
# => "одна целая и пять десятых рубля"

I18n.with_locale(:fr) { 1.5.to_words(unit: :euro) }
# => "un virgule cinq euro"
```

`subunit` spells an amount in two units, such as dollars and cents. The decimal places, rounded half to even, become the subunit. `precision` sets how many places make one subunit, 2 by default. A zero subunit is left out unless `zero_subunit: true`. A zero unit is left out with `remove_zero: true`, where the language supports it. The two parts are joined with the language's word (`and` in English, `et` in French), attached to the subunit in Hebrew and Arabic (`ו`, `و`), or else with a space.

```ruby
I18n.with_locale(:en) { 21.5.to_words(unit: :dollar, subunit: :cent) }
# => "twenty-one dollars and fifty cents"

I18n.with_locale(:ru) { 22.22.to_words(unit: :ruble, subunit: :kopeck) }
# => "двадцать два рубля двадцать две копейки"

I18n.with_locale(:fr) { 21.01.to_words(unit: :euro, subunit: :centime) }
# => "vingt et un euros et un centime"

I18n.with_locale(:en) { 21.to_words(unit: :dollar, subunit: :cent, zero_subunit: true) }
# => "twenty-one dollars and zero cents"

I18n.with_locale(:en) { 0.5.to_words(unit: :dollar, subunit: :cent, remove_zero: true) }
# => "fifty cents"
```

`subunit` without `unit`, `subunit` with `ordinal: true`, and `zero_subunit` without `subunit` raise `NumbersAndWords::UnsupportedOptionError`.

### Unsupported Options

Every language accepts `precision`, `micro_separator`, `fallback`, `unit`, `subunit` and `zero_subunit`, plus the options on its page. Any other option or value is ignored with a warning that lists the supported ones. 2.0 will raise `NumbersAndWords::UnsupportedOptionError`, an `ArgumentError`, instead. Set [`strict_options`](#configuration--конфигурация) to `true` to raise now.

Vietnamese has no grammatical gender, so `21.to_words(gender: :female)` in `vi` returns "hai mươi mốt" and warns once:

```
numbers_and_words: The option :gender is not supported in :vi; supported: :micro_separator, :ordinal, :precision, :remove_zero, :subunit, :unit, :zero_subunit. It is ignored; set NumbersAndWords.config.strict_options = true to raise, the default in 2.0.
```

### Deprecations

Three defaults change in 2.0: `fraction: true` in English, French, Italian and Portuguese, `spelling: :traditional` in French, and `hundreds_with_union: false` in British English. Pass the option to choose. The locale codes `se`, `ua` and `kz` are deprecated; use `sv`, `uk` and `kk`. Each deprecation warns once per process. Warnings about defaults are Ruby deprecation warnings, shown only with `Warning[:deprecated] = true` or `ruby -W:deprecated`. See [UPGRADING](UPGRADING.md).

## Configuration / Конфигурация

All bundled locales load by default. To load only some, configure the gem after requiring it:

```ruby
NumbersAndWords.configure do |config|
  config.locales = [:en, :ru]
end
```

Or set it directly:

```ruby
NumbersAndWords.config.locales = [:en, :ru]
```

Regional locales such as `"en-US"` become their bundled locale. `nil` restores all bundled locales and `[]` loads none. An unsupported locale raises `ArgumentError` and changes nothing. An assignment takes effect at once. A `configure` block takes effect when it completes, and not at all if it raises.

`fallback` sets the default [fallback](#fallback); the `fallback` option of `to_words` overrides it.

```ruby
NumbersAndWords.config.fallback = :en
```

`strict_options` is `false` by default: an unsupported option or value is ignored with a warning. Set it to `true` to raise `NumbersAndWords::UnsupportedOptionError`, as 2.0 will by default.

```ruby
NumbersAndWords.config.strict_options = true
```

Configuration only changes this gem's locale files in `I18n.load_path` and its plural rules. It keeps application translations and an assigned `I18n.available_locales`. Converting in a disabled locale raises `NumbersAndWords::UnsupportedLanguageError` (`Language not configured`) unless a fallback is set.

Require the gem before looking up translations, as Rails does, and configure it during initialization. Configuring reloads the I18n backend, as assigning `I18n.load_path` does, so store runtime-only translations afterwards. Configuring again doesn't duplicate load paths. The gem never changes `I18n.locale` or `I18n.default_locale`, so don't disable their locales.

## Requirements / Требования / Configuration Requise

* Ruby 3.1 or later, including JRuby.
* I18n, tested with 1.6 and later.

## Upgrading / Обновление / Mise à jour

See [UPGRADING](UPGRADING.md) for changes in behavior and what 2.0 will change.

## Contributing / Участие / Contribuer

See [CONTRIBUTING](CONTRIBUTING.md), [AGENTS](AGENTS.md), [CHANGELOG](CHANGELOG.md), [UPGRADING](UPGRADING.md), [BENCHMARKS](BENCHMARKS.md) and [RELEASING](RELEASING.md).

## License / Лицензия / Licence

MIT License, see [LICENSE](LICENSE.txt).
