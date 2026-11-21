# French (`fr`)

Français.

Aliases: `fr-CA`.

## Examples

```ruby
I18n.with_locale(:fr) { 0.to_words }
# => "zéro"

I18n.with_locale(:fr) { 21.to_words }
# => "vingt-et-un"

I18n.with_locale(:fr) { 231.to_words }
# => "deux-cent-trente-et-un"

I18n.with_locale(:fr) { 4030.to_words }
# => "quatre-mille-trente"

I18n.with_locale(:fr) { 1_000_100.to_words }
# => "un million cent"

I18n.with_locale(:fr) { 2_000_000_000.to_words }
# => "deux milliards"

I18n.with_locale(:fr) { [1, 2, 3].to_words }
# => ["un", "deux", "trois"]

I18n.with_locale(:fr) { [11, 22, 133].to_words }
# => ["onze", "vingt-deux", "cent-trente-trois"]
```

## Decimals

```ruby
I18n.with_locale(:fr) { 21.77.to_words }
# => "vingt-et-un et soixante-dix-sept centièmes"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:fr) { 0.1.to_words(precision: 2) }
# => "zéro et dix centièmes"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:fr) { 21.77.to_words(micro_separator: "plus") }
# => "vingt-et-un plus soixante-dix-sept centièmes"
```

### Ordinal

`ordinal: true` gives the masculine form: 1 alone is premier, and otherwise only the last word takes the suffix -ième, dropping a final e or plural s ("deux-centième"). Decimals keep the cardinal form.

```ruby
I18n.with_locale(:fr) { 1.to_words(ordinal: true) }
# => "premier"

I18n.with_locale(:fr) { 21.to_words(ordinal: true) }
# => "vingt-et-unième"

I18n.with_locale(:fr) { 80.to_words(ordinal: true) }
# => "quatre-vingtième"

I18n.with_locale(:fr) { 200.to_words(ordinal: true) }
# => "deux-centième"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:fr) { 0.7.to_words(remove_zero: true) }
# => "sept dixièmes"
```

### Spelling

French follows the 1990 spelling reform by default (`spelling: :reformed`), hyphenating every numeral in a compound number except the nouns million, milliard and larger. `spelling: :traditional` gives the earlier spelling, with spaces and without hyphens around `et`, `cent` and `mille`.

```ruby
I18n.with_locale(:fr) { 321.to_words }
# => "trois-cent-vingt-et-un"

I18n.with_locale(:fr) { 2_000_021.to_words }
# => "deux millions vingt-et-un"

I18n.with_locale(:fr) { 280_000_000.to_words }
# => "deux-cent-quatre-vingts millions"

I18n.with_locale(:fr) { 321.to_words(spelling: :traditional) }
# => "trois cent vingt et un"

I18n.with_locale(:fr) { 2_000_021.to_words(spelling: :traditional) }
# => "deux millions vingt et un"
```
