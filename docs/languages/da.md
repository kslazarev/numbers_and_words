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
# => "fire tusinde og tredive"

I18n.with_locale(:da) { 1_000_100.to_words }
# => "en million et hundrede"

I18n.with_locale(:da) { 2_000_000_000.to_words }
# => "to milliarder"

I18n.with_locale(:da) { [1, 2, 3].to_words }
# => ["et", "to", "tre"]

I18n.with_locale(:da) { [11, 22, 133].to_words }
# => ["elleve", "toogtyve", "et hundrede og treogtredive"]
```

Decimals are not supported yet.

## Gender

`gender: :common` or :neuter

```ruby
I18n.with_locale(:da) { 1.to_words(gender: :common) }
# => "en"

I18n.with_locale(:da) { 1.to_words(gender: :neuter) }
# => "et"
```
