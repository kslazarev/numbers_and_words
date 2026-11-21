# Estonian (`et`)

Eesti. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:et) { 0.to_words }
# => "null"

I18n.with_locale(:et) { 21.to_words }
# => "kakskümmend üks"

I18n.with_locale(:et) { 231.to_words }
# => "kakssada kolmkümmend üks"

I18n.with_locale(:et) { 4030.to_words }
# => "neli tuhat kolmkümmend"

I18n.with_locale(:et) { 1_000_100.to_words }
# => "üks miljon ükssada"

I18n.with_locale(:et) { 2_000_000_000.to_words }
# => "kaks miljardit"

I18n.with_locale(:et) { [1, 2, 3].to_words }
# => ["üks", "kaks", "kolm"]

I18n.with_locale(:et) { [11, 22, 133].to_words }
# => ["üksteist", "kakskümmend kaks", "ükssada kolmkümmend kolm"]
```

## Decimals

Ordinary decimal readings are not supported yet. Converting a float without `unit` and `subunit`, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("decimals are not supported in :et"). Amounts with both [`unit` and `subunit`](../../README.md#unit) are supported.

## Options

### Precision

With `unit` and `subunit`, `precision` sets how many decimal places make one subunit (2 by default). It does not enable ordinary decimal readings.

### Micro Separator

`micro_separator` applies to ordinary decimal readings, which are not supported yet. It does not change the separator between a unit and its subunit.

### Ordinal

`ordinal: true` makes the last word ordinal and puts the words before it in the genitive ("kahekümne esimene"). Ordinals in this language are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:et) { 1.to_words(ordinal: true) }
# => "esimene"

I18n.with_locale(:et) { 21.to_words(ordinal: true) }
# => "kahekümne esimene"

I18n.with_locale(:et) { 2_000.to_words(ordinal: true) }
# => "kahe tuhandes"
```
