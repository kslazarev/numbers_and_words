# Danish (`da`)

Dansk. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

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

Decimals are read with komma and then each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:da) { 3.14.to_words }
# => "tre komma en fire"

I18n.with_locale(:da) { 21.05.to_words }
# => "enogtyve komma nul fem"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:da) { 0.1.to_words(precision: 2) }
# => "nul komma en nul"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:da) { 21.77.to_words(micro_separator: "punktum") }
# => "enogtyve punktum syv syv"
```

### Gender

`gender: :common` or `gender: :neuter`. Without it, 1 is the counting form `en`. Hundreds and thousands always take the neuter `et` (`et hundrede`, `et tusind`).

```ruby
I18n.with_locale(:da) { 1.to_words(gender: :common) }
# => "en"

I18n.with_locale(:da) { 1.to_words(gender: :neuter) }
# => "et"
```

### Ordinal

`ordinal: true` makes the last word, or the last part of a compound, ordinal ("enogtyvende"). Second is `anden`, or `andet` with `gender: :neuter`.

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

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps komma.

```ruby
I18n.with_locale(:da) { 0.7.to_words(remove_zero: true) }
# => "komma syv"
```

## Sources

- [Dansk Sprognævn: Numeral Inflection](https://sproget.dk/sprogviden/spoergsmaal-og-svar/dansk-sprognaevn/sv00004961/): Common-gender anden and neuter andet.
- [Lex: Store tal](https://lex.dk/store_tal): Scale names up to kvintilliard (10<sup>33</sup>).
- [Unicode CLDR: Danish Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/da.xml): The spell-out rules ICU uses to write numbers in words.
