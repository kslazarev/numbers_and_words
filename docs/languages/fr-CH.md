# Swiss French (`fr-CH`)

Français (Suisse). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:'fr-CH') { 0.to_words }
# => "zéro"

I18n.with_locale(:'fr-CH') { 21.to_words }
# => "vingt-et-un"

I18n.with_locale(:'fr-CH') { 231.to_words }
# => "deux-cent-trente-et-un"

I18n.with_locale(:'fr-CH') { 4030.to_words }
# => "quatre-mille-trente"

I18n.with_locale(:'fr-CH') { 1_000_100.to_words }
# => "un million cent"

I18n.with_locale(:'fr-CH') { 2_000_000_000.to_words }
# => "deux milliards"

I18n.with_locale(:'fr-CH') { [1, 2, 3].to_words }
# => ["un", "deux", "trois"]

I18n.with_locale(:'fr-CH') { [11, 22, 133].to_words }
# => ["onze", "vingt-deux", "cent-trente-trois"]
```

## Decimals

Decimals are read with `virgule` followed by the fractional part: up to three decimal places as a number after one `zéro` for each leading zero, and longer ones digit by digit.

```ruby
I18n.with_locale(:'fr-CH') { 21.77.to_words }
# => "vingt-et-un virgule septante-sept"

I18n.with_locale(:'fr-CH') { 3.05.to_words }
# => "trois virgule zéro cinq"

I18n.with_locale(:'fr-CH') { 3.1416.to_words }
# => "trois virgule un quatre un six"
```

## Options

### Unit

As in French, zero takes the singular unit when application translations provide `one` and `other` forms ("zéro euro"). An explicit `zero` unit translation takes precedence.

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:'fr-CH') { 0.1.to_words(precision: 2) }
# => "zéro virgule dix"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:'fr-CH') { 21.77.to_words(micro_separator: "plus") }
# => "vingt-et-un plus septante-sept"
```

### Fraction

`fraction: true` reads decimals as a fraction instead of with `virgule`.

```ruby
I18n.with_locale(:'fr-CH') { 21.77.to_words(fraction: true) }
# => "vingt-et-un et septante-sept centièmes"

I18n.with_locale(:'fr-CH') { 0.1.to_words(fraction: true) }
# => "zéro et un dixième"
```

### Ordinal

`ordinal: true` gives the masculine form: 1 alone is premier, and otherwise only the last word takes the suffix -ième, dropping a final e or plural s ("deux-centième"). The ordinal of a round million or larger is a numeral, so the 1990 spelling joins it to its multiplier with a hyphen ("deux-millionième"; traditional "deux millionième"). Decimals keep the cardinal form.

```ruby
I18n.with_locale(:'fr-CH') { 1.to_words(ordinal: true) }
# => "premier"

I18n.with_locale(:'fr-CH') { 21.to_words(ordinal: true) }
# => "vingt-et-unième"

I18n.with_locale(:'fr-CH') { 80.to_words(ordinal: true) }
# => "huitantième"

I18n.with_locale(:'fr-CH') { 200.to_words(ordinal: true) }
# => "deux-centième"

I18n.with_locale(:'fr-CH') { 2_000_000.to_words(ordinal: true) }
# => "deux-millionième"

I18n.with_locale(:'fr-CH') { 2_000_000.to_words(ordinal: true, spelling: :traditional) }
# => "deux millionième"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:'fr-CH') { 0.7.to_words(remove_zero: true) }
# => "virgule sept"
```

### Spelling

Swiss French follows the 1990 spelling reform by default (`spelling: :reformed`), hyphenating every numeral in a compound number except the nouns million, milliard and larger. `spelling: :traditional` gives the earlier spelling, with spaces and without hyphens around `et`, `cent` and `mille`.

```ruby
I18n.with_locale(:'fr-CH') { 71.to_words }
# => "septante-et-un"

I18n.with_locale(:'fr-CH') { 321.to_words }
# => "trois-cent-vingt-et-un"

I18n.with_locale(:'fr-CH') { 2_000_021.to_words }
# => "deux millions vingt-et-un"

I18n.with_locale(:'fr-CH') { 71.to_words(spelling: :traditional) }
# => "septante et un"

I18n.with_locale(:'fr-CH') { 321.to_words(spelling: :traditional) }
# => "trois cent vingt et un"

I18n.with_locale(:'fr-CH') { 2_000_021.to_words(spelling: :traditional) }
# => "deux millions vingt et un"
```
