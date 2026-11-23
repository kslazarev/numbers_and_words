# Bosnian (`bs`)

Bosanski is the Bosnian name of the language, written in the Latin script. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers are written as separate words, with the ones after the tens (dvadeset jedan), as in Unicode CLDR. Dvadeset i jedan is also in use. Numbers are ijekavian (dvije, dvjesta). A thousand alone is hiljadu (hiljadu dvjesta), and a count of thousands is feminine (dvije hiljade, dvadeset jedna hiljada). Scale words follow the long scale: milion (10<sup>6</sup>), milijarda (10<sup>9</sup>), bilion (10<sup>12</sup>), bilijarda and so on up to kvintilijarda (10<sup>33</sup>). Those in -ion are masculine (jedan milion, dva miliona) and those in -ijarda feminine (jedna milijarda, dvije milijarde, pet milijardi). A scale word agrees with the last numeral of its count (dvadeset jedan milion, sto dvadeset tri hiljade). Unicode CLDR stops at biliard (10<sup>15</sup>), so the names from trilion (10<sup>18</sup>) on follow the same pattern and await a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Bosnian and Croatian differ in their words (hiljada and tisuća, milion and milijun) and in the i between tens and ones, so neither locale extends the other.

## Examples

```ruby
I18n.with_locale(:bs) { 0.to_words }
# => "nula"

I18n.with_locale(:bs) { 21.to_words }
# => "dvadeset jedan"

I18n.with_locale(:bs) { 1234.to_words }
# => "hiljadu dvjesta trideset četiri"

I18n.with_locale(:bs) { 22_000.to_words }
# => "dvadeset dvije hiljade"

I18n.with_locale(:bs) { 21_000_000.to_words }
# => "dvadeset jedan milion"

I18n.with_locale(:bs) { 5_000_000_000.to_words }
# => "pet milijardi"

I18n.with_locale(:bs) { [11, 22, 133].to_words }
# => ["jedanaest", "dvadeset dva", "sto trideset tri"]
```

## Decimals

Decimals are read as a neuter whole number with cijelo, cijela or cijelih, then i and a feminine number of desetinke, stotinke or hiljaditinke, as in Croatian. The fraction words await a native speaker's review. Up to eleven fractional digits are supported; more raise `RangeError`.

```ruby
I18n.with_locale(:bs) { 1.5.to_words }
# => "jedno cijelo i pet desetinki"

I18n.with_locale(:bs) { 3.14.to_words }
# => "tri cijela i četrnaest stotinki"

I18n.with_locale(:bs) { 0.02.to_words }
# => "nula cijelih i dvije stotinke"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:bs) { 0.1.to_words(precision: 2) }
# => "nula cijelih i deset stotinki"
```

### Micro Separator

The `micro_separator` option replaces the i between the integral and fractional parts.

```ruby
I18n.with_locale(:bs) { 2.5.to_words(micro_separator: 'plus') }
# => "dva cijela plus pet desetinki"
```

### Gender

The `gender` option, `:male` (default), `:female` or `:neuter`, changes one and two at the end of the number (jedan, jedna, jedno; dva, dvije, dva).

```ruby
I18n.with_locale(:bs) { 1.to_words(gender: :male) }
# => "jedan"

I18n.with_locale(:bs) { 22.to_words(gender: :female) }
# => "dvadeset dvije"

I18n.with_locale(:bs) { 101.to_words(gender: :neuter) }
# => "sto jedno"
```

### Ordinal

The `ordinal: true` option makes the last word ordinal (dvadeset prvi), in the requested gender (prva, prvo; treća, treće). A round thousand or larger scale is joined to its count, which is left out when it is one (hiljaditi, dvijehiljaditi, milioniti, dvamilioniti). This joined form awaits a native speaker's review. Ordinals are spelled up to the largest cardinal. Unicode CLDR has no Bosnian ordinals.

```ruby
I18n.with_locale(:bs) { 21.to_words(ordinal: true) }
# => "dvadeset prvi"

I18n.with_locale(:bs) { 23.to_words(ordinal: true, gender: :neuter) }
# => "dvadeset treće"

I18n.with_locale(:bs) { 1001.to_words(ordinal: true, gender: :female) }
# => "hiljadu prva"

I18n.with_locale(:bs) { 2000.to_words(ordinal: true) }
# => "dvijehiljaditi"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part. The ordinal of zero stays nulti.

```ruby
I18n.with_locale(:bs) { 0.7.to_words(remove_zero: true) }
# => "sedam desetinki"
```

## Sources

- [Unicode CLDR: Bosnian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/bs.xml): Cardinals up to 10<sup>15</sup> without i between tens and ones. Its ekavian dve and dvesta, its feminine one jedinica and its milion after two to four aren't followed.
- [Unicode CLDR: Plural Rules](https://github.com/unicode-org/cldr/blob/main/common/supplemental/plurals.xml): The one, few and other forms of scale words and fractions.
- [GeoGebra: Decimalni brojevi](https://geogebra.org/resource/fdahkgd2/yh353lzN4gSCqxCX/material-fdahkgd2.pdf): The reading of decimals shared with Croatian (pet cijelih i sedam desetinki, nula cijelih i osam stotinki).
