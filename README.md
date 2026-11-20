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

Call `to_words` on an integer, a float or an array within the locale of your choice.

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

Floats that Ruby prints in scientific notation, such as `0.00001` (`1.0e-05`), are expanded to their exact decimal value first.

```ruby
I18n.with_locale(:en) { 0.00001.to_words }
# => "zero and one hundred-thousandth"
```

## Supported Languages / Языки / Langues Supportées

Each language page has examples and the options that language supports.

| Language | Name | Code | Decimals | Ordinals |
| --- | --- | --- | --- | --- |
| [Armenian](docs/languages/hy.md) | Հայերեն | `hy` | no | no |
| [Brazilian Portuguese](docs/languages/pt-BR.md) | Português Brasileiro | `pt-BR` | yes | yes |
| [British English](docs/languages/en-GB.md) | English (British) | `en-GB` | yes | yes |
| [Czech](docs/languages/cs.md) | Čeština | `cs` | yes | yes |
| [Danish](docs/languages/da.md) | Dansk | `da` | no | no |
| [Dutch](docs/languages/nl.md) | Nederlands | `nl` | yes | no |
| [English](docs/languages/en.md) | English | `en` | yes | yes |
| [Estonian](docs/languages/et.md) | Eesti | `et` | no | no |
| [French](docs/languages/fr.md) | Français | `fr` | yes | no |
| [Georgian](docs/languages/ka.md) | ქართული | `ka` | no | no |
| [German](docs/languages/de.md) | Deutsch | `de` | yes | yes |
| [Hungarian](docs/languages/hu.md) | Magyar | `hu` | yes | yes |
| [Italian](docs/languages/it.md) | Italiano | `it` | yes | no |
| [Kazakh](docs/languages/kz.md) | Қазақша | `kz` | no | no |
| [Latvian](docs/languages/lv.md) | Latviešu | `lv` | no | no |
| [Lithuanian](docs/languages/lt.md) | Lietuvių | `lt` | no | no |
| [Polish](docs/languages/pl.md)* | Polski | `pl` | yes | yes |
| [Portuguese](docs/languages/pt.md) | Português | `pt` | yes | no |
| [Russian](docs/languages/ru.md) | Русский | `ru` | yes | no |
| [Spanish](docs/languages/es.md) | Español | `es` | yes | no |
| [Swedish](docs/languages/se.md)* | Svenska | `se` | no | no |
| [Swiss French](docs/languages/fr-CH.md) | Français (Suisse) | `fr-CH` | yes | no |
| [Turkish](docs/languages/tr.md) | Türkçe | `tr` | no | no |
| [Ukrainian](docs/languages/ua.md) | Українська | `ua` | yes | no |
| [Vietnamese](docs/languages/vi.md) | Tiếng Việt | `vi` | yes | no |

\* Experimental: the language has known gaps or has not been reviewed by a native speaker yet; its page says why. See [#255](https://github.com/kslazarev/numbers_and_words/issues/255) to help.

Regional locales use their language: `en-AU`, `en-CA`, `en-IN` and `en-US` use `en`; `fr-CA` uses `fr`; `de-AT` and `de-CH` use `de`; `it-CH` uses `it`.

## Options / Опции / Options

Options are passed to `to_words`. Language-specific options such as `gender`, `ordinal` or `remove_zero` are described on each language page linked from Supported Languages.

### Precision

`precision` pads the fractional part of a float with zeros.

```ruby
I18n.with_locale(:ru) { 0.1.to_words(precision: 3) }
# => "ноль целых и сто тысячных"

I18n.with_locale(:es) { 0.2.to_words(precision: 2) }
# => "cero con veinte centésimas"
```

## Requirements / Требования / Configuration Requise

* Ruby 3.2 or later, including JRuby.
* I18n, tested with 1.6 and later.

## Upgrading / Обновление / Mise à jour

See [UPGRADING](UPGRADING.md) for breaking changes and how to upgrade.

## Contributing / Участие / Contribuer

See [CONTRIBUTING](CONTRIBUTING.md), [AGENTS](AGENTS.md), [CHANGELOG](CHANGELOG.md), [UPGRADING](UPGRADING.md), [BENCHMARKS](BENCHMARKS.md) and [RELEASING](RELEASING.md).

## License / Лицензия / Licence

MIT License, see [LICENSE](LICENSE.txt).
