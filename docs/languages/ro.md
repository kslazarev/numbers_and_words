# Romanian (`ro`)

Română is the Romanian name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers agree with the noun they count. Mie is feminine (o mie, două mii, douăzeci și una de mii). Milion and larger scales are neuter, so they take the masculine one and the feminine two (un milion, două milioane, douăzeci și unu de milioane). A count whose last two digits are 00 or 20 to 99 takes `de` before the noun (douăzeci de mii, o sută de milioane); one ending in 01 to 19 does not (nouăsprezece mii). By default the last group uses the masculine counting form (unu, doi, douăzeci și unu); see [Gender](#gender). Romanian uses the long scale: bilion is 10<sup>12</sup> and biliard 10<sup>15</sup>, followed by trilion, triliard, cvadrilion, cvadriliard, cvintilion and cvintiliard (10<sup>33</sup>). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

With [`unit`](../../README.md#unit), a unit takes its `one` form after 1, and `few` after 0, counts ending in 01 to 19 and decimals ("douăzeci și unu virgulă cinci lei"). It takes `other` after counts ending in 00 or 20 to 99, so `other` includes `de`: `{ one: leu, few: lei, other: de lei }` gives "douăzeci de lei". One before a unit is `un`, or `o` for a feminine unit ("un leu", "o liră"). Compounds keep the counting form ("o sută unu lei", "douăzeci și una de lire").

## Examples

```ruby
I18n.with_locale(:ro) { 0.to_words }
# => "zero"

I18n.with_locale(:ro) { 12.to_words }
# => "doisprezece"

I18n.with_locale(:ro) { 21.to_words }
# => "douăzeci și unu"

I18n.with_locale(:ro) { 101.to_words }
# => "o sută unu"

I18n.with_locale(:ro) { 2_000.to_words }
# => "două mii"

I18n.with_locale(:ro) { 21_000.to_words }
# => "douăzeci și una de mii"

I18n.with_locale(:ro) { 1_000_000.to_words }
# => "un milion"

I18n.with_locale(:ro) { 2_000_000.to_words }
# => "două milioane"

I18n.with_locale(:ro) { 123_456_789.to_words }
# => "o sută douăzeci și trei de milioane patru sute cincizeci și șase de mii șapte sute optzeci și nouă"

I18n.with_locale(:ro) { [1, 2, 3].to_words }
# => ["unu", "doi", "trei"]
```

## Decimals

Decimals are read with `virgulă` followed by the fractional part: up to three decimal places as a number, after a `zero` for each leading zero, and longer ones digit by digit. The fractional part uses the masculine counting form.

```ruby
I18n.with_locale(:ro) { 3.14.to_words }
# => "trei virgulă paisprezece"

I18n.with_locale(:ro) { 21.05.to_words }
# => "douăzeci și unu virgulă zero cinci"

I18n.with_locale(:ro) { 3.1416.to_words }
# => "trei virgulă unu patru unu șase"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:ro) { 0.1.to_words(precision: 2) }
# => "zero virgulă zece"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ro) { 21.77.to_words(micro_separator: 'punct') }
# => "douăzeci și unu punct șaptezeci și șapte"
```

### Gender

The `gender: :male` (default), `:female` or `:neuter` option sets the gender of the last group of digits. Neuter nouns take the masculine one and the feminine two (un scaun, două scaune).

```ruby
I18n.with_locale(:ro) { 1.to_words(gender: :female) }
# => "una"

I18n.with_locale(:ro) { 22.to_words(gender: :female) }
# => "douăzeci și două"

I18n.with_locale(:ro) { 12.to_words(gender: :neuter) }
# => "douăsprezece"
```

### Ordinal

The `ordinal: true` option gives the ordinal with its article: masculine by default (primul, al doilea, al douăzeci și unulea) and feminine with `gender: :female` (prima, a doua, a douăzeci și una). Neuter nouns take the masculine ordinal. Only the last word changes (al două miilea), and a leading un before a scale is dropped (al milionulea). Zero keeps its cardinal form.

```ruby
I18n.with_locale(:ro) { 2.to_words(ordinal: true) }
# => "al doilea"

I18n.with_locale(:ro) { 21.to_words(ordinal: true) }
# => "al douăzeci și unulea"

I18n.with_locale(:ro) { 2.to_words(ordinal: true, gender: :female) }
# => "a doua"

I18n.with_locale(:ro) { 100.to_words(ordinal: true) }
# => "al o sutălea"

I18n.with_locale(:ro) { 1000.to_words(ordinal: true) }
# => "al o miilea"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part.

```ruby
I18n.with_locale(:ro) { 0.7.to_words(remove_zero: true) }
# => "virgulă șapte"
```

## Sources

- [DEX/DOOM: unulea](https://dexonline.ro/definitie/unulea): An ordinal form of one.
- [DEX/DOOM: sutălea](https://dexonline.ro/definitie/sut%C4%83lea): Hundredth forms.
- [DEX/DOOM: miilea](https://dexonline.ro/definitie/miilea): Thousandth forms.
- [DEX/DOOM: cvadrilion](https://dexonline.ro/definitie/cvadrilion): The spelling cvadrilion and its plural cvadrilioane.
- [DEX/DOOM: cvintilion](https://dexonline.ro/definitie/cvintilion): The spelling cvintilion and its plural cvintilioane.
- [Unicode CLDR: Romanian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/ro.xml): The spell-out rules ICU uses to write numbers in words.
