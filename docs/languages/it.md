# Italian (`it`)

Italiano. Cento drops its final o before otto and ottanta (centotto, duecentottanta). Numbers up to 10<sup>48</sup> - 1 are supported; larger numbers raise `RangeError`.

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

Decimals are read with `virgola` followed by the fractional part: up to three decimal places as a number after one `zero` for each leading zero, and longer ones digit by digit.

```ruby
I18n.with_locale(:it) { 21.77.to_words }
# => "ventuno virgola settantasette"

I18n.with_locale(:it) { 3.05.to_words }
# => "tre virgola zero cinque"

I18n.with_locale(:it) { 3.1416.to_words }
# => "tre virgola uno quattro uno sei"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:it) { 0.1.to_words(precision: 2) }
# => "zero virgola dieci"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:it) { 21.77.to_words(micro_separator: "plus") }
# => "ventuno plus settantasette"
```

### Fraction

`fraction: true` reads decimals as a fraction instead of with `virgola`.

```ruby
I18n.with_locale(:it) { 21.77.to_words(fraction: true) }
# => "ventuno e settantasette centesimi"

I18n.with_locale(:it) { 0.1.to_words(fraction: true) }
# => "zero e un decimo"
```

### Ordinal

`ordinal: true` gives the masculine form. Above ten the ordinal is one word ending in -esimo ("ventunesimo", "duemillesimo"). Zero keeps its cardinal form.

```ruby
I18n.with_locale(:it) { 1.to_words(ordinal: true) }
# => "primo"

I18n.with_locale(:it) { 21.to_words(ordinal: true) }
# => "ventunesimo"

I18n.with_locale(:it) { 2_000.to_words(ordinal: true) }
# => "duemillesimo"

I18n.with_locale(:it) { 180.to_words(ordinal: true) }
# => "centottantesimo"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:it) { 0.7.to_words(remove_zero: true) }
# => "virgola sette"
```
