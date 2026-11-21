# Danish (`da`)

Dansk.

## Examples

```ruby
I18n.with_locale(:da) { 0.to_words }
# => "nul"

I18n.with_locale(:da) { 21.to_words }
# => "enogtyve"

I18n.with_locale(:da) { 231.to_words }
# => "to hundrede og enogtredive"

I18n.with_locale(:da) { 4030.to_words }
# => "fire tusind og tredive"

I18n.with_locale(:da) { 1_000_100.to_words }
# => "en million et hundrede"

I18n.with_locale(:da) { 2_000_000_000.to_words }
# => "to milliarder"

I18n.with_locale(:da) { [1, 2, 3].to_words }
# => ["en", "to", "tre"]

I18n.with_locale(:da) { [11, 22, 133].to_words }
# => ["elleve", "toogtyve", "et hundrede og treogtredive"]
```

## Decimals

Decimals are not supported yet.

## Options

### Precision

`precision` pads the fractional part of a decimal, so it has no effect until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal, so it has no effect until decimals are supported.

### Gender

`gender:` is `:common` or `:neuter`. Without it, 1 uses the counting form `en`. Hundreds and thousands always take the neuter `et` (`et hundrede`, `et tusind`).

```ruby
I18n.with_locale(:da) { 1.to_words(gender: :common) }
# => "en"

I18n.with_locale(:da) { 1.to_words(gender: :neuter) }
# => "et"
```
