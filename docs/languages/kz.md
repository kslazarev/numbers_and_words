# Kazakh (`kz`)

Қазақша.

## Examples

```ruby
I18n.with_locale(:kz) { 0.to_words }
# => "нөл"

I18n.with_locale(:kz) { 21.to_words }
# => "жиырма бір"

I18n.with_locale(:kz) { 231.to_words }
# => "екі жүз отыз бір"

I18n.with_locale(:kz) { 4030.to_words }
# => "төрт мың отыз"

I18n.with_locale(:kz) { 1_000_100.to_words }
# => "бір миллион бір жүз"

I18n.with_locale(:kz) { 2_000_000_000.to_words }
# => "екі миллиард"

I18n.with_locale(:kz) { [1, 2, 3].to_words }
# => ["бір", "екі", "үш"]

I18n.with_locale(:kz) { [11, 22, 133].to_words }
# => ["он бір", "жиырма екі", "бір жүз отыз үш"]
```

## Decimals

Decimals are not supported yet.

## Options

### Precision

`precision` pads the fractional part of a decimal, so it has no effect until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal, so it has no effect until decimals are supported.
