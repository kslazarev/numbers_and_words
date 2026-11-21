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
# => "twenty-one point seven seven"
```

Floats that Ruby prints in scientific notation, such as `0.00001` (`1.0e-05`), are converted from their exact decimal value.

```ruby
I18n.with_locale(:en) { 0.00001.to_words }
# => "zero point zero zero zero zero one"
```

### Command Line

The `to_words` command spells out each argument, or each number read from standard input, one per line.

```
$ to_words 42 1.5
forty-two
one point five

$ to_words --locale ru 2000
две тысячи

$ echo 21 | to_words --ordinal
twenty-first

$ to_words --locale es --gender female 21
veintiuna
```

Choose the language with `-l`/`--locale` (default `en`). Every `to_words` option has a flag, such as `--ordinal` (with a `--no-` form), `--gender VALUE` or `--precision N`; `to_words --help` lists them with the languages that support each. Errors go to standard error with exit status 1.

## Supported Languages / Языки / Langues Supportées

Each language page has examples, says whether decimals are supported, and documents every option the language accepts.

| Language | Name | Code |
| --- | --- | --- |
| [Arabic](docs/languages/ar.md)* | العربية | `ar` |
| [Armenian](docs/languages/hy.md) | Հայերեն | `hy` |
| [Azerbaijani](docs/languages/az.md)* | Azərbaycan dili | `az` |
| [Bengali](docs/languages/bn.md)* | বাংলা | `bn` |
| [Brazilian Portuguese](docs/languages/pt-BR.md) | Português Brasileiro | `pt-BR` |
| [British English](docs/languages/en-GB.md) | English (British) | `en-GB` |
| [Bulgarian](docs/languages/bg.md)* | Български | `bg` |
| [Chinese](docs/languages/zh.md)* | 中文 | `zh` |
| [Czech](docs/languages/cs.md) | Čeština | `cs` |
| [Danish](docs/languages/da.md) | Dansk | `da` |
| [Dutch](docs/languages/nl.md) | Nederlands | `nl` |
| [English](docs/languages/en.md) | English | `en` |
| [Estonian](docs/languages/et.md) | Eesti | `et` |
| [Finnish](docs/languages/fi.md)* | Suomi | `fi` |
| [French](docs/languages/fr.md) | Français | `fr` |
| [Georgian](docs/languages/ka.md) | ქართული | `ka` |
| [German](docs/languages/de.md) | Deutsch | `de` |
| [Greek](docs/languages/el.md)* | Ελληνικά | `el` |
| [Hebrew](docs/languages/he.md)* | עברית | `he` |
| [Hindi](docs/languages/hi.md)* | हिन्दी | `hi` |
| [Hungarian](docs/languages/hu.md) | Magyar | `hu` |
| [Indonesian](docs/languages/id.md) | Bahasa Indonesia | `id` |
| [Italian](docs/languages/it.md) | Italiano | `it` |
| [Japanese](docs/languages/ja.md)* | 日本語 | `ja` |
| [Kazakh](docs/languages/kk.md) | Қазақша | `kk` |
| [Korean](docs/languages/ko.md)* | 한국어 | `ko` |
| [Latvian](docs/languages/lv.md) | Latviešu | `lv` |
| [Lithuanian](docs/languages/lt.md) | Lietuvių | `lt` |
| [Malay](docs/languages/ms.md)* | Bahasa Melayu | `ms` |
| [Norwegian Bokmål](docs/languages/nb.md)* | Norsk bokmål | `nb` |
| [Polish](docs/languages/pl.md)* | Polski | `pl` |
| [Portuguese](docs/languages/pt.md) | Português | `pt` |
| [Romanian](docs/languages/ro.md)* | Română | `ro` |
| [Russian](docs/languages/ru.md) | Русский | `ru` |
| [Slovak](docs/languages/sk.md)* | Slovenčina | `sk` |
| [Spanish](docs/languages/es.md) | Español | `es` |
| [Swedish](docs/languages/sv.md)* | Svenska | `sv` |
| [Swiss French](docs/languages/fr-CH.md) | Français (Suisse) | `fr-CH` |
| [Thai](docs/languages/th.md)* | ภาษาไทย | `th` |
| [Turkish](docs/languages/tr.md) | Türkçe | `tr` |
| [Ukrainian](docs/languages/uk.md) | Українська | `uk` |
| [Urdu](docs/languages/ur.md)* | اردو | `ur` |
| [Vietnamese](docs/languages/vi.md) | Tiếng Việt | `vi` |

\* Experimental: known gaps, or no native-speaker review yet; its page says why. See [#255](https://github.com/kslazarev/numbers_and_words/issues/255) to help.

Regional locales use their language: `en-AU`, `en-CA`, `en-IN` and `en-US` use `en`; `fr-CA` uses `fr`; `de-AT` and `de-CH` use `de`; `it-CH` uses `it`; `nb-NO`, `no` and `no-NO` use `nb`; `zh-CN` and `zh-SG` use `zh`.

## Options / Опции / Options

Options are passed to `to_words`. Language-specific options, such as `gender`, `ordinal` or `remove_zero`, are described on each language page.

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
# => "twenty-one plus seven seven"
```

### Fallback

`fallback` decides what happens when the current locale has no bundled rules or the configuration disables it. By default this raises `NumbersAndWords::UnsupportedLanguageError`. Set it to a bundled locale to convert in that locale, or to `true` to return the digits.

```ruby
I18n.with_locale(:am) { 42.to_words(fallback: :fr) }
# => "quarante-deux"

I18n.with_locale(:am) { 42.to_words(fallback: true) }
# => "42"
```

Other options are validated for the fallback locale. `I18n.with_locale` raises `I18n::InvalidLocale` for a locale missing from `I18n.available_locales` before the gem is called. To set a fallback for every call, see [Configuration](#configuration--конфигурация).

### Unit

`unit` follows a number with a unit word, such as a currency, in the form the number takes. The gem ships no units: `unit: :ruble` looks up `units.ruble` in your application's translations for the current locale, and a dotted key such as `"money.ruble"` looks up `units.money.ruble`. A unit has one form per plural category of the language, chosen with the gem's plural rules (`one`, `few`, `many` and `other` in Russian and Ukrainian, `one` and `other` in English), or a single string for a unit that never changes. An optional `gender` sets the gender of the number in languages with a `gender` option; a `gender` passed to `to_words` overrides it.

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

The unit follows the number after a space, or directly in languages written without spaces (Chinese, Japanese and Thai). With `ordinal: true` the unit takes its singular (`one`) form, because an ordinal names one item: the twenty-first dollar.

```ruby
I18n.with_locale(:en) { 21.to_words(unit: :dollar, ordinal: true) }
# => "twenty-first dollar"

I18n.with_locale(:ru) { 22.to_words(unit: :kopeck, ordinal: true) }
# => "двадцать вторая копейка"
```

A unit without a translation, or without the form a number needs and no `other` form, raises `NumbersAndWords::UnsupportedOptionError`, for example `unit :euro has no translation for locale :ru (expected units.euro)`. Unit forms are nominative, so `unit` with a `case` other than `:nominative` raises too.

After a decimal, the unit takes its `other` form, which is the genitive singular in Russian and Czech; in French and Portuguese, amounts below 2 take the singular, and in Romanian the unit takes its `few` form. A float with no fractional part reads as a whole number.

```ruby
I18n.with_locale(:en) { 1.5.to_words(unit: :dollar) }
# => "one point five dollars"

I18n.with_locale(:ru) { 1.5.to_words(unit: :ruble) }
# => "одна целая и пять десятых рубля"

I18n.with_locale(:fr) { 1.5.to_words(unit: :euro) }
# => "un virgule cinq euro"
```

`subunit` spells an amount in two units, such as dollars and cents: the decimal places become the subunit, rounded half to even. `precision` sets how many decimal places make one subunit, 2 by default. A zero subunit is left out unless `zero_subunit: true`, and a zero unit is left out with `remove_zero: true` in languages that support it. The two parts are joined with the language's word for it (`and` in English, `et` in French) or a space.

```ruby
I18n.with_locale(:en) { 21.5.to_words(unit: :dollar, subunit: :cent) }
# => "twenty-one dollars and fifty cents"

I18n.with_locale(:ru) { 22.22.to_words(unit: :ruble, subunit: :kopeck) }
# => "двадцать два рубля двадцать две копейки"

I18n.with_locale(:fr) { 21.01.to_words(unit: :euro, subunit: :centime) }
# => "vingt-et-un euros et un centime"

I18n.with_locale(:en) { 21.to_words(unit: :dollar, subunit: :cent, zero_subunit: true) }
# => "twenty-one dollars and zero cents"

I18n.with_locale(:en) { 0.5.to_words(unit: :dollar, subunit: :cent, remove_zero: true) }
# => "fifty cents"
```

`subunit` without `unit`, or with `ordinal: true`, raises `NumbersAndWords::UnsupportedOptionError`, and so does `zero_subunit` without `subunit`.

### Unsupported Options

Every language accepts `precision`, `micro_separator`, `fallback`, `unit`, `subunit` and `zero_subunit`, plus the options on its language page. Any other option or value raises `NumbersAndWords::UnsupportedOptionError`, an `ArgumentError` that names the supported alternatives.

Vietnamese has no grammatical gender, so `21.to_words(gender: :female)` in `vi` raises:

```
NumbersAndWords::UnsupportedOptionError: unsupported option :gender for locale :vi; supported: :micro_separator, :ordinal, :precision, :remove_zero, :subunit, :unit, :zero_subunit
```

## Configuration / Конфигурация

All bundled locales are loaded by default. To load only some, configure the gem after requiring it:

```ruby
NumbersAndWords.configure do |config|
  config.locales = [:en, :ru]
end
```

Or set it directly:

```ruby
NumbersAndWords.config.locales = [:en, :ru]
```

Regional locales such as `"en-US"` are normalized to their bundled locale. `nil` restores all bundled locales and `[]` loads none. An unsupported locale raises `ArgumentError` and changes nothing. A direct assignment takes effect immediately; a `configure` block takes effect when it completes, and not at all if it raises.

`fallback` sets the default [fallback](#fallback); the `fallback` option of `to_words` overrides it.

```ruby
NumbersAndWords.config.fallback = :en
```

Configuration changes only this gem's locale files in `I18n.load_path` and its pluralization rules; application translations and an explicitly assigned `I18n.available_locales` are kept. Converting in a disabled locale raises `NumbersAndWords::UnsupportedLanguageError` (`Language not configured`) unless a fallback is set.

Require the gem before looking up any translations, as Rails does, and configure it during application initialization. Configuring reloads the I18n backend, as assigning `I18n.load_path` does, so store runtime-only translations afterwards. Configuring again doesn't duplicate load paths. The gem never changes `I18n.locale` or `I18n.default_locale`, so don't disable the locales they use.

## Requirements / Требования / Configuration Requise

* Ruby 3.2 or later, including JRuby.
* I18n, tested with 1.6 and later.

## Upgrading / Обновление / Mise à jour

See [UPGRADING](UPGRADING.md) for breaking changes and how to upgrade.

## Contributing / Участие / Contribuer

See [CONTRIBUTING](CONTRIBUTING.md), [AGENTS](AGENTS.md), [CHANGELOG](CHANGELOG.md), [UPGRADING](UPGRADING.md), [BENCHMARKS](BENCHMARKS.md) and [RELEASING](RELEASING.md).

## License / Лицензия / Licence

MIT License, see [LICENSE](LICENSE.txt).
