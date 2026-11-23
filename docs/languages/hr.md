# Croatian (`hr`)

Hrvatski is the Croatian name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers are written as separate words, with i between the tens and the ones (dvadeset i jedan), as in Unicode CLDR; dvadeset jedan is also in use. A thousand alone is tisuću (tisuću dvjesto), and a count of thousands is feminine (dvije tisuće, dvadeset i jedna tisuća). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Scale words follow the long scale: milijun (10<sup>6</sup>), milijarda (10<sup>9</sup>), bilijun (10<sup>12</sup>), bilijarda and so on up to kvintilijarda (10<sup>33</sup>). Those in -ijun are masculine (jedan milijun, dva milijuna), and those in -ijarda are feminine (jedna milijarda, dvije milijarde, pet milijardi). A scale word agrees with the last numeral of its count (dvadeset i jedan milijun, sto dvadeset i tri tisuće). CLDR stops at bilijarda (10<sup>15</sup>). The names from trilijun (10<sup>18</sup>) on follow the same pattern and need a native speaker's review.

## Examples

```ruby
I18n.with_locale(:hr) { 0.to_words }
# => "nula"

I18n.with_locale(:hr) { 21.to_words }
# => "dvadeset i jedan"

I18n.with_locale(:hr) { 1234.to_words }
# => "tisuću dvjesto trideset i četiri"

I18n.with_locale(:hr) { 22_000.to_words }
# => "dvadeset i dvije tisuće"

I18n.with_locale(:hr) { 21_000_000.to_words }
# => "dvadeset i jedan milijun"

I18n.with_locale(:hr) { 5_000_000_000.to_words }
# => "pet milijardi"

I18n.with_locale(:hr) { [11, 22, 133].to_words }
# => ["jedanaest", "dvadeset i dva", "sto trideset i tri"]
```

## Decimals

Decimals are read as Croatian schools teach: a neuter whole number with cijelo, cijela or cijelih, then i and a feminine count of desetinke, stotinke or tisućinke. Up to eleven fractional digits are supported; more raise `RangeError`.

```ruby
I18n.with_locale(:hr) { 1.5.to_words }
# => "jedno cijelo i pet desetinki"

I18n.with_locale(:hr) { 3.14.to_words }
# => "tri cijela i četrnaest stotinki"

I18n.with_locale(:hr) { 0.02.to_words }
# => "nula cijelih i dvije stotinke"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:hr) { 0.1.to_words(precision: 2) }
# => "nula cijelih i deset stotinki"
```

### Micro Separator

The `micro_separator` option replaces the i between the integral and fractional parts.

```ruby
I18n.with_locale(:hr) { 2.5.to_words(micro_separator: "plus") }
# => "dva cijela plus pet desetinki"
```

### Gender

With `gender: :male` (the default), `:female` or `:neuter`, one and two change at the end of the number (jedan, jedna, jedno; dva, dvije, dva).

```ruby
I18n.with_locale(:hr) { 1.to_words(gender: :male) }
# => "jedan"

I18n.with_locale(:hr) { 22.to_words(gender: :female) }
# => "dvadeset i dvije"

I18n.with_locale(:hr) { 101.to_words(gender: :neuter) }
# => "sto jedno"
```

### Ordinal

With `ordinal: true`, the last word becomes ordinal, in the requested gender (prva, prvo; treća, treće), and the i after the tens is dropped (dvadeset prvi). A round thousand or larger scale is one word with its count, and a count of one is left out (tisućiti, dvijetisućiti, milijunti, dvamilijunti). This joined form needs a native speaker's review. Ordinals are spelled up to the largest supported number.

```ruby
I18n.with_locale(:hr) { 21.to_words(ordinal: true) }
# => "dvadeset prvi"

I18n.with_locale(:hr) { 23.to_words(ordinal: true, gender: :neuter) }
# => "dvadeset treće"

I18n.with_locale(:hr) { 1001.to_words(ordinal: true, gender: :female) }
# => "tisuću prva"

I18n.with_locale(:hr) { 2000.to_words(ordinal: true) }
# => "dvijetisućiti"
```

### Remove Zero

With `remove_zero: true`, a zero integral part is omitted. The ordinal of zero stays nulti.

```ruby
I18n.with_locale(:hr) { 0.7.to_words(remove_zero: true) }
# => "sedam desetinki"
```

## Sources

- [Unicode CLDR: Croatian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/hr.xml): Cardinals up to bilijarda (10<sup>15</sup>), tisuću and the i between tens and ones. Its ordinals from 100 on use Czech stems and aren't followed.
- [Unicode CLDR: Plural Rules](https://github.com/unicode-org/cldr/blob/main/common/supplemental/plurals.xml): The one, few and other forms of scale words and fractions.
- [GeoGebra: Decimalni brojevi](https://geogebra.org/resource/fdahkgd2/yh353lzN4gSCqxCX/material-fdahkgd2.pdf): The school reading of decimals (pet cijelih i sedam desetinki, nula cijelih i osam stotinki).
