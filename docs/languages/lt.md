# Lithuanian (`lt`)

Lietuvių.

## Examples

```ruby
I18n.with_locale(:lt) { 0.to_words }
# => "nulis"

I18n.with_locale(:lt) { 21.to_words }
# => "dvidešimt vienas"

I18n.with_locale(:lt) { 231.to_words }
# => "du šimtai trisdešimt vienas"

I18n.with_locale(:lt) { 4030.to_words }
# => "keturi tūkstančiai trisdešimt"

I18n.with_locale(:lt) { 1_000_100.to_words }
# => "vienas milijonas šimtas"

I18n.with_locale(:lt) { 2_000_000_000.to_words }
# => "du milijardai"

I18n.with_locale(:lt) { [1, 2, 3].to_words }
# => ["vienas", "du", "trys"]

I18n.with_locale(:lt) { [11, 22, 133].to_words }
# => ["vienuolika", "dvidešimt du", "šimtas trisdešimt trys"]
```

## Decimals

Decimals are not supported yet.

## Options

### Precision

`precision` pads the fractional part of a decimal, so it has no effect until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal, so it has no effect until decimals are supported.
