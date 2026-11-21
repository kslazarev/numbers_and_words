# Spanish (`es`)

Español. Numbers up to 10<sup>48</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:es) { 0.to_words }
# => "cero"

I18n.with_locale(:es) { 21.to_words }
# => "veintiuno"

I18n.with_locale(:es) { 231.to_words }
# => "doscientos treinta y uno"

I18n.with_locale(:es) { 4030.to_words }
# => "cuatro mil treinta"

I18n.with_locale(:es) { 1_000_100.to_words }
# => "un millón cien"

I18n.with_locale(:es) { 2_000_000_000.to_words }
# => "dos mil millones"

I18n.with_locale(:es) { [1, 2, 3].to_words }
# => ["uno", "dos", "tres"]

I18n.with_locale(:es) { [11, 22, 133].to_words }
# => ["once", "veintidós", "ciento treinta y tres"]
```

## Decimals

Decimals are read as the integral part, `con`, and the fractional part as a number of décimas, centésimas, milésimas and so on, counted in the feminine.

```ruby
I18n.with_locale(:es) { 21.77.to_words }
# => "veintiuno con setenta y siete centésimas"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:es) { 0.1.to_words(precision: 2) }
# => "cero con diez centésimas"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:es) { 21.77.to_words(micro_separator: "plus") }
# => "veintiuno plus setenta y siete centésimas"
```

### Apocopated

`apocopated: true` shortens a final masculine `uno` to `un`, and the ordinals `primero` and `tercero` to `primer` and `tercer`, as before a masculine noun. The feminine `una` is not shortened. With a [`unit`](../../README.md#unit) that isn't feminine, the number is shortened unless `apocopated: false` is given (un euro, veintiún céntimos).

```ruby
I18n.with_locale(:es) { 1.to_words(apocopated: true) }
# => "un"

I18n.with_locale(:es) { 201.to_words(apocopated: true) }
# => "doscientos un"

I18n.with_locale(:es) { 201.to_words(gender: :female, apocopated: true) }
# => "doscientas una"

I18n.with_locale(:es) { 21.to_words(ordinal: true, apocopated: true) }
# => "vigésimo primer"
```

### Gender

`gender: :male` (default) or `gender: :female`

```ruby
I18n.with_locale(:es) { 1.to_words(gender: :female) }
# => "una"

I18n.with_locale(:es) { 1.to_words(gender: :male) }
# => "uno"
```

### Ordinal

`ordinal: true` makes every part of the number ordinal ("vigésimo primero") and joins a scale word to its multiplier ("dosmilésimo"). A joined multiplier loses its accent, changes internal `y` to `i`, and stays masculine; `gender: :female` changes the ordinal ending only ("veintidosmilésima"). Zero keeps its cardinal form.

```ruby
I18n.with_locale(:es) { 1.to_words(ordinal: true) }
# => "primero"

I18n.with_locale(:es) { 21.to_words(ordinal: true) }
# => "vigésimo primero"

I18n.with_locale(:es) { 2_000.to_words(ordinal: true) }
# => "dosmilésimo"

I18n.with_locale(:es) { 21.to_words(ordinal: true, gender: :female) }
# => "vigésima primera"

I18n.with_locale(:es) { 22_000.to_words(ordinal: true, gender: :female) }
# => "veintidosmilésima"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:es) { 0.7.to_words(remove_zero: true) }
# => "siete décimas"
```
