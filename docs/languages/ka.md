# Georgian (`ka`)

ქართული. Scale words are ათასი, მილიონი, მილიარდი and ტრილიონი. Numbers up to 10<sup>15</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:ka) { 0.to_words }
# => "ნული"

I18n.with_locale(:ka) { 21.to_words }
# => "ოცდაერთი"

I18n.with_locale(:ka) { 231.to_words }
# => "ორას ოცდათერთმეტი"

I18n.with_locale(:ka) { 4030.to_words }
# => "ოთხი ათას ოცდაათი"

I18n.with_locale(:ka) { 1_000_100.to_words }
# => "ერთი მილიონ ასი"

I18n.with_locale(:ka) { 2_000_000_000.to_words }
# => "ორი მილიარდი"

I18n.with_locale(:ka) { [1, 2, 3].to_words }
# => ["ერთი", "ორი", "სამი"]

I18n.with_locale(:ka) { [11, 22, 133].to_words }
# => ["თერთმეტი", "ოცდაორი", "ას ოცდაცამეტი"]
```

## Decimals

Ordinary decimal readings are not supported yet. Converting a float without `unit` and `subunit`, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("decimals are not supported in :ka"). Amounts with both [`unit` and `subunit`](../../README.md#unit) are supported.

## Options

### Precision

With `unit` and `subunit`, `precision` sets how many decimal places make one subunit (2 by default). It does not enable ordinary decimal readings.

### Micro Separator

`micro_separator` applies to ordinary decimal readings, which are not supported yet. It does not change the separator between a unit and its subunit.

### Ordinal

`ordinal: true` gives პირველი for 1, and otherwise adds მე- and -ე to the last word, or to the last part of a compound ("ოცდამეერთე"). Ordinals of a multiple of a thousand or more are supported only for one (მეათასე, მემილიონე); others, such as 2,000, raise `RangeError` until a native speaker confirms their form. Ordinals in this language are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:ka) { 1.to_words(ordinal: true) }
# => "პირველი"

I18n.with_locale(:ka) { 21.to_words(ordinal: true) }
# => "ოცდამეერთე"

I18n.with_locale(:ka) { 1_000.to_words(ordinal: true) }
# => "მეათასე"

I18n.with_locale(:ka) { 2_021.to_words(ordinal: true) }
# => "ორი ათას ოცდამეერთე"
```
