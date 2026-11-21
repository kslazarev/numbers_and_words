# Latvian (`lv`)

Latviešu. A hundred is simts on its own and simt before another word (simt viens, simt tūkstoši). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:lv) { 0.to_words }
# => "nulle"

I18n.with_locale(:lv) { 21.to_words }
# => "divdesmit viens"

I18n.with_locale(:lv) { 231.to_words }
# => "divi simti trīsdesmit viens"

I18n.with_locale(:lv) { 4030.to_words }
# => "četri tūkstoši trīsdesmit"

I18n.with_locale(:lv) { 1_000_100.to_words }
# => "viens miljons simts"

I18n.with_locale(:lv) { 2_000_000_000.to_words }
# => "divi miljardi"

I18n.with_locale(:lv) { [1, 2, 3].to_words }
# => ["viens", "divi", "trīs"]

I18n.with_locale(:lv) { [11, 22, 133].to_words }
# => ["vienpadsmit", "divdesmit divi", "simt trīsdesmit trīs"]
```

## Decimals

Decimals are not supported yet. Converting a float, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("decimals are not supported in :lv").

## Options

### Precision

`precision` pads the fractional part of a decimal; floats raise `NumbersAndWords::UnsupportedNumberError` until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal; floats raise `NumbersAndWords::UnsupportedNumberError` until decimals are supported.

### Ordinal

`ordinal: true` makes the last word ordinal ("divdesmit pirmais"). A round hundred, thousand or larger scale is one word with the combining form of a one-word multiplier (divsimtais, piectūkstošais, desmittūkstošais, divmiljonais); a multiplier of several words stays separate (divdesmit viens tūkstošais). Ordinals in this language are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:lv) { 1.to_words(ordinal: true) }
# => "pirmais"

I18n.with_locale(:lv) { 21.to_words(ordinal: true) }
# => "divdesmit pirmais"

I18n.with_locale(:lv) { 2_000.to_words(ordinal: true) }
# => "divtūkstošais"

I18n.with_locale(:lv) { 101.to_words(ordinal: true) }
# => "simt pirmais"
```
