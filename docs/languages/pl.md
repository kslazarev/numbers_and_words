# Polish (`pl`)

Polski. This language is experimental: cardinals support magnitudes below 10**48 and decimals up to 48 places; ordinals support 0 to 999; general noun-case and masculine-personal inflection are not implemented.

## Examples

```ruby
I18n.with_locale(:pl) { 0.to_words }
# => "zero"

I18n.with_locale(:pl) { 21.to_words }
# => "dwadzieścia jeden"

I18n.with_locale(:pl) { 231.to_words }
# => "dwieście trzydzieści jeden"

I18n.with_locale(:pl) { 4030.to_words }
# => "cztery tysiące trzydzieści"

I18n.with_locale(:pl) { 1_000_100.to_words }
# => "milion sto"

I18n.with_locale(:pl) { 2_000_000_000.to_words }
# => "dwa miliardy"

I18n.with_locale(:pl) { 21_000.to_words }
# => "dwadzieścia jeden tysięcy"

I18n.with_locale(:pl) { [1, 2, 3].to_words }
# => ["jeden", "dwa", "trzy"]

I18n.with_locale(:pl) { [11, 22, 133].to_words }
# => ["jedenaście", "dwadzieścia dwa", "sto trzydzieści trzy"]

I18n.with_locale(:pl) { 21.77.to_words }
# => "dwadzieścia jeden całych i siedemdziesiąt siedem setnych"
```

## Gender

`gender: :male` (default), `:female` or `:neuter`

```ruby
I18n.with_locale(:pl) { 1.to_words(gender: :female) }
# => "jedna"

I18n.with_locale(:pl) { 22.to_words(gender: :female) }
# => "dwadzieścia dwie"

I18n.with_locale(:pl) { 2.to_words(gender: :neuter) }
# => "dwa"
```

## Ordinal

`ordinal: true`, optionally with gender, for integers from 0 to 999. Larger ordinals raise `RangeError`.

```ruby
I18n.with_locale(:pl) { 21.to_words(ordinal: true) }
# => "dwudziesty pierwszy"

I18n.with_locale(:pl) { 121.to_words(ordinal: true, gender: :female) }
# => "sto dwudziesta pierwsza"
```

## Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:pl) { 0.1.to_words(remove_zero: true) }
# => "jedna dziesiąta"
```
