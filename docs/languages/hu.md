# Hungarian (`hu`)

Magyar.

## Examples

```ruby
I18n.with_locale(:hu) { 0.to_words }
# => "nulla"

I18n.with_locale(:hu) { 21.to_words }
# => "huszonegy"

I18n.with_locale(:hu) { 231.to_words }
# => "kétszázharmincegy"

I18n.with_locale(:hu) { 4030.to_words }
# => "négyezer-harminc"

I18n.with_locale(:hu) { 1_000_100.to_words }
# => "egymillió-száz"

I18n.with_locale(:hu) { 2_000_000_000.to_words }
# => "kétmilliárd"

I18n.with_locale(:hu) { [1, 2, 3].to_words }
# => ["egy", "kettő", "három"]

I18n.with_locale(:hu) { [11, 22, 133].to_words }
# => ["tizenegy", "huszonkettő", "százharminchárom"]
```

## Decimals

```ruby
I18n.with_locale(:hu) { 21.77.to_words }
# => "huszonegy egész hetvenhét század"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:hu) { 0.1.to_words(precision: 2) }
# => "nulla egész tíz század"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:hu) { 21.77.to_words(micro_separator: "plus") }
# => "huszonegy plus hetvenhét század"
```

### Ordinal

`ordinal: true`

```ruby
I18n.with_locale(:hu) { 21.to_words(ordinal: true) }
# => "huszonegyedik"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:hu) { 0.7.to_words(remove_zero: true) }
# => "hét tized"
```
