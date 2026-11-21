# Lithuanian (`lt`)

Lietuvių. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:lt) { 0.to_words }
# => "nulis"

I18n.with_locale(:lt) { 21.to_words }
# => "dvidešimt vienas"

I18n.with_locale(:lt) { 231.to_words }
# => "du šimtai trisdešimt vienas"

I18n.with_locale(:lt) { 4030.to_words }
# => "keturi tūkstančiai trisdešimt"

I18n.with_locale(:lt) { 1_000_100.to_words }
# => "vienas milijonas šimtas"

I18n.with_locale(:lt) { 2_000_000_000.to_words }
# => "du milijardai"

I18n.with_locale(:lt) { [1, 2, 3].to_words }
# => ["vienas", "du", "trys"]

I18n.with_locale(:lt) { [11, 22, 133].to_words }
# => ["vienuolika", "dvidešimt du", "šimtas trisdešimt trys"]
```

## Decimals

Decimals are not supported yet. Converting a float, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("decimals are not supported in :lt").

## Options

### Precision

`precision` pads the fractional part of a decimal; floats raise `NumbersAndWords::UnsupportedNumberError` until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal; floats raise `NumbersAndWords::UnsupportedNumberError` until decimals are supported.

### Ordinal

`ordinal: true` makes the last word ordinal ("dvidešimt pirmas"). Ordinals use the indefinite form (pirmas, dešimtas), except round hundreds and thousands, which take the definite form that is standard for them (šimtasis, tūkstantasis), and millions and larger, which take -inis (milijoninis). A round hundred, thousand or larger scale is one word with the combining form of a one-word multiplier (dušimtasis, penkiatūkstantasis, dešimttūkstantasis, dumilijoninis); a multiplier of several words stays separate (dvidešimt vienas tūkstantasis). Ordinals in this language are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:lt) { 1.to_words(ordinal: true) }
# => "pirmas"

I18n.with_locale(:lt) { 21.to_words(ordinal: true) }
# => "dvidešimt pirmas"

I18n.with_locale(:lt) { 2_000.to_words(ordinal: true) }
# => "dutūkstantasis"
```
