# Norwegian Bokmål (`nb`)

Norsk bokmål. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers use the modern counting system (tjueen, not en og tjue) and sju and tretti, not syv and tredve. "og" joins tens and ones to hundreds (hundre og en) and a last part below one hundred to the rest (tusen og en). Tusen is neuter, so a one before it is ett (hundre og ett tusen). A leading hundred or thousand has no "ett" (hundre, tusen); after a larger part it is "ett hundre" or "ett tusen". Million and larger scales are nouns: en million, to millioner, en milliard. Numbers up to 10<sup>21</sup> - 1 are supported; larger numbers raise `RangeError`. Regional locales such as `nb-NO` use `nb`, and `no` is an alias of `nb`.

## Examples

```ruby
I18n.with_locale(:nb) { 0.to_words }
# => "null"

I18n.with_locale(:nb) { 21.to_words }
# => "tjueen"

I18n.with_locale(:nb) { 231.to_words }
# => "to hundre og trettien"

I18n.with_locale(:nb) { 1001.to_words }
# => "tusen og en"

I18n.with_locale(:nb) { 4030.to_words }
# => "fire tusen og tretti"

I18n.with_locale(:nb) { 1_000_100.to_words }
# => "en million ett hundre"

I18n.with_locale(:nb) { 2_000_000_000.to_words }
# => "to milliarder"

I18n.with_locale(:nb) { [1, 2, 3].to_words }
# => ["en", "to", "tre"]

I18n.with_locale(:nb) { [11, 22, 133].to_words }
# => ["elleve", "tjueto", "hundre og trettitre"]
```

## Decimals

Decimals are read with komma and then each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:nb) { 3.14.to_words }
# => "tre komma en fire"

I18n.with_locale(:nb) { 21.05.to_words }
# => "tjueen komma null fem"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:nb) { 0.1.to_words(precision: 2) }
# => "null komma en null"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:nb) { 21.77.to_words(micro_separator: "punktum") }
# => "tjueen punktum sju sju"
```

### Gender

`gender: :male` (the default, en), `:female` (ei) or `:neuter` (ett) is the gender of what is counted. It applies only to a last part of exactly one; compounds keep "en" (tjueen).

```ruby
I18n.with_locale(:nb) { 1.to_words(gender: :male) }
# => "en"

I18n.with_locale(:nb) { 1.to_words(gender: :female) }
# => "ei"

I18n.with_locale(:nb) { 101.to_words(gender: :neuter) }
# => "hundre og ett"
```

### Ordinal

`ordinal: true` makes the last word, or the ones of a compound, ordinal (tjueførste). One hundred, one thousand and one million are the ordinal of the scale word alone.

```ruby
I18n.with_locale(:nb) { 1.to_words(ordinal: true) }
# => "første"

I18n.with_locale(:nb) { 21.to_words(ordinal: true) }
# => "tjueførste"

I18n.with_locale(:nb) { 1_000_000.to_words(ordinal: true) }
# => "millionte"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps komma.

```ruby
I18n.with_locale(:nb) { 0.7.to_words(remove_zero: true) }
# => "komma sju"
```

## Sources

- [Språkrådet: Numbers, Time and Dates](https://sprakradet.no/godt-og-korrekt-sprak/rettskriving-og-grammatikk/tall-tid-dato/): Norwegian numeral conventions.
- [Bokmålsordboka: tjueen](https://ordbokene.no/nob/bm/tjueen): Compound cardinal spelling.
- [Unicode CLDR: Norwegian Bokmål Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/nb.xml): The spell-out rules ICU uses to write numbers in words.
