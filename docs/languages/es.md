# Spanish (`es`)

Español.

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

I18n.with_locale(:es) { 21.77.to_words }
# => "veintiuno con setenta y siete centésimas"
```

## Gender

`gender: :male` (default) or :female

```ruby
I18n.with_locale(:es) { 1.to_words(gender: :female) }
# => "una"

I18n.with_locale(:es) { 1.to_words(gender: :male) }
# => "uno"
```

## Apocopated

`apocopated: true` uses the shortened form, alone or with gender.

```ruby
I18n.with_locale(:es) { 1.to_words(apocopated: true) }
# => "un"

I18n.with_locale(:es) { 201.to_words(gender: :female, apocopated: true) }
# => "doscientas un"
```

## Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:es) { 0.7.to_words(remove_zero: true) }
# => "siete décimas"
```
