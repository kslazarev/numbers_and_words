# Italian (`it`)

Italiano.

Aliases: `it-CH`.

## Examples

```ruby
I18n.with_locale(:it) { 0.to_words }
# => "zero"

I18n.with_locale(:it) { 21.to_words }
# => "ventuno"

I18n.with_locale(:it) { 231.to_words }
# => "duecentotrentuno"

I18n.with_locale(:it) { 4030.to_words }
# => "quattromilatrenta"

I18n.with_locale(:it) { 1_000_100.to_words }
# => "un milione cento"

I18n.with_locale(:it) { 2_000_000_000.to_words }
# => "due miliardi"

I18n.with_locale(:it) { 1_001_000.to_words }
# => "un milione mille"

I18n.with_locale(:it) { [1, 2, 3].to_words }
# => ["uno", "due", "tre"]

I18n.with_locale(:it) { [11, 22, 133].to_words }
# => ["undici", "ventidue", "centotrentatré"]
```

## Decimals

```ruby
I18n.with_locale(:it) { 21.77.to_words }
# => "ventuno e settantasette centesimi"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:it) { 0.1.to_words(precision: 2) }
# => "zero e dieci centesimi"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:it) { 21.77.to_words(micro_separator: "plus") }
# => "ventuno plus settantasette centesimi"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:it) { 0.7.to_words(remove_zero: true) }
# => "sette decimi"
```
