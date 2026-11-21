# Georgian (`ka`)

ქართული.

## Examples

```ruby
I18n.with_locale(:ka) { 0.to_words }
# => "ნული"

I18n.with_locale(:ka) { 21.to_words }
# => "ოცდაერთი"

I18n.with_locale(:ka) { 231.to_words }
# => "ორას ოცდათერთმეტი"

I18n.with_locale(:ka) { 4030.to_words }
# => "ოთხი ათას ოცდაათი"

I18n.with_locale(:ka) { 1_000_100.to_words }
# => "ერთი მილიონ ასი"

I18n.with_locale(:ka) { 2_000_000_000.to_words }
# => "ორი მილიარდი"

I18n.with_locale(:ka) { [1, 2, 3].to_words }
# => ["ერთი", "ორი", "სამი"]

I18n.with_locale(:ka) { [11, 22, 133].to_words }
# => ["თერთმეტი", "ოცდაორი", "ას ოცდაცამეტი"]
```

## Decimals

Decimals are not supported yet.

## Options

### Precision

`precision` pads the fractional part of a decimal, so it has no effect until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal, so it has no effect until decimals are supported.
