# Swedish (`sv`)

Svenska. Numbers below a million are written as one word (tjugoettusen, fyratusentrettio), and ett drops a t before tusen (ettusen). This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:sv) { 0.to_words }
# => "noll"

I18n.with_locale(:sv) { 21.to_words }
# => "tjugoett"

I18n.with_locale(:sv) { 231.to_words }
# => "tvåhundratrettioett"

I18n.with_locale(:sv) { 4030.to_words }
# => "fyratusentrettio"

I18n.with_locale(:sv) { 1_000_100.to_words }
# => "en miljon etthundra"

I18n.with_locale(:sv) { 2_000_000_000.to_words }
# => "två miljarder"

I18n.with_locale(:sv) { [1, 2, 3].to_words }
# => ["ett", "två", "tre"]

I18n.with_locale(:sv) { [11, 22, 133].to_words }
# => ["elva", "tjugotvå", "etthundratrettiotre"]
```

## Decimals

Decimals are not supported yet. Converting a float, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("decimals are not supported in :sv").

## Options

### Precision

`precision` pads the fractional part of a decimal; floats raise `NumbersAndWords::UnsupportedNumberError` until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal; floats raise `NumbersAndWords::UnsupportedNumberError` until decimals are supported.

### Ordinal

`ordinal: true` makes the end of the last word ordinal ("tjugoförsta").

```ruby
I18n.with_locale(:sv) { 1.to_words(ordinal: true) }
# => "första"

I18n.with_locale(:sv) { 21.to_words(ordinal: true) }
# => "tjugoförsta"

I18n.with_locale(:sv) { 2_000.to_words(ordinal: true) }
# => "tvåtusende"
```
