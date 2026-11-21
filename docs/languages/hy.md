# Armenian (`hy`)

Հայերեն. Numbers up to 10<sup>18</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:hy) { 0.to_words }
# => "զրո"

I18n.with_locale(:hy) { 21.to_words }
# => "քսանմեկ"

I18n.with_locale(:hy) { 231.to_words }
# => "երկու հարյուր երեսունմեկ"

I18n.with_locale(:hy) { 4030.to_words }
# => "չորս հազար երեսուն"

I18n.with_locale(:hy) { 1_000_100.to_words }
# => "մեկ միլիոն հարյուր"

I18n.with_locale(:hy) { 2_000_000_000.to_words }
# => "երկու միլիարդ"

I18n.with_locale(:hy) { 1_000_000_000_000_000.to_words }
# => "մեկ կվադրիլիոն"

I18n.with_locale(:hy) { [1, 2, 3].to_words }
# => ["մեկ", "երկու", "երեք"]

I18n.with_locale(:hy) { [11, 22, 133].to_words }
# => ["տասնմեկ", "քսաներկու", "հարյուր երեսուներեք"]
```

## Decimals

Ordinary decimal readings are not supported yet. Converting a float without `unit` and `subunit`, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("decimals are not supported in :hy"). Amounts with both [`unit` and `subunit`](../../README.md#unit) are supported.

## Options

### Precision

With `unit` and `subunit`, `precision` sets how many decimal places make one subunit (2 by default). It does not enable ordinary decimal readings.

### Micro Separator

`micro_separator` applies to ordinary decimal readings, which are not supported yet. It does not change the separator between a unit and its subunit.

### Ordinal

`ordinal: true` gives առաջին to չորրորդ for 1 to 4, and otherwise adds -երորդ to the last word ("քսանմեկերորդ"), changing a final ը to ն first ("իններորդ", "տասներորդ"). Ordinals in this language are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:hy) { 1.to_words(ordinal: true) }
# => "առաջին"

I18n.with_locale(:hy) { 21.to_words(ordinal: true) }
# => "քսանմեկերորդ"

I18n.with_locale(:hy) { 2_000.to_words(ordinal: true) }
# => "երկու հազարերորդ"

I18n.with_locale(:hy) { 1_000_000_000_000_000.to_words(ordinal: true) }
# => "կվադրիլիոներորդ"
```
