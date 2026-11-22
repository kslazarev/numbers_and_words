# Danish (`da`)

Dansk. Numbers up to 10<sup>21</sup> - 1 are supported; larger numbers raise `RangeError`.

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

Ordinary decimal readings are not supported yet. Converting a float without `unit` and `subunit`, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("Decimals are not supported in :da."). Amounts with both [`unit` and `subunit`](../../README.md#unit) are supported.

## Options

### Precision

With `unit` and `subunit`, `precision` sets how many decimal places make one subunit (2 by default). It does not enable ordinary decimal readings.

### Micro Separator

`micro_separator` applies to ordinary decimal readings, which are not supported yet. It does not change the separator between a unit and its subunit.

### Gender

`gender:` is `:common` or `:neuter`. Without it, 1 uses the counting form `en`. Hundreds and thousands always take the neuter `et` (`et hundrede`, `et tusind`).

```ruby
I18n.with_locale(:da) { 1.to_words(gender: :common) }
# => "en"

I18n.with_locale(:da) { 1.to_words(gender: :neuter) }
# => "et"
```

### Ordinal

`ordinal: true` makes the last word ordinal, or the last part of a compound ("enogtyvende"). Second is `anden` in the common gender and `andet` with `gender: :neuter`.

```ruby
I18n.with_locale(:da) { 1.to_words(ordinal: true) }
# => "første"

I18n.with_locale(:da) { 21.to_words(ordinal: true) }
# => "enogtyvende"

I18n.with_locale(:da) { 2_000.to_words(ordinal: true) }
# => "to tusinde"

I18n.with_locale(:da) { 2.to_words(ordinal: true, gender: :neuter) }
# => "andet"
```

## Sources

- [Dansk Sprognævn: Numeral Inflection](https://sproget.dk/sprogviden/spoergsmaal-og-svar/dansk-sprognaevn/sv00004961/): Common-gender anden and neuter andet.
- [Unicode CLDR: Danish Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/da.xml): The spell-out rules ICU uses to write numbers in words.
