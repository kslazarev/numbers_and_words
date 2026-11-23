# Catalan (`ca`)

Català is the Catalan name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

As the Institut d'Estudis Catalans prescribes, units join the tens with a hyphen, or with -i- in the twenties (trenta-dos, vint-i-u), and the hundreds join their count (dos-cents). Cent and the other parts are written apart (cent vint-i-tres). One is u when counting, as Unicode CLDR's spellout-numbering reads it, and un as the count of mil and the scale words (vint-i-un mil, un milió); see [Gender](#gender) for una. Mil leaves out a count of one (mil, dos mil). Scales follow the long scale: milió (10<sup>6</sup>), bilió (10<sup>12</sup>), trilió, quadrilió, quintilió and sextilió (10<sup>36</sup>), and a thousand of each between them (mil milions for 10<sup>9</sup>, mil bilions for 10<sup>15</sup>), as the Institut d'Estudis Catalans recommends and Unicode CLDR's current rules do; the rarer miliard and biliard aren't used. Unicode CLDR stops at mil bilions (10<sup>15</sup>), so the larger names follow the same pattern and need a native speaker's review. Numbers up to 10<sup>42</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:ca) { 0.to_words }
# => "zero"

I18n.with_locale(:ca) { 17.to_words }
# => "disset"

I18n.with_locale(:ca) { 21.to_words }
# => "vint-i-u"

I18n.with_locale(:ca) { 245.to_words }
# => "dos-cents quaranta-cinc"

I18n.with_locale(:ca) { 2_021.to_words }
# => "dos mil vint-i-u"

I18n.with_locale(:ca) { 21_000.to_words }
# => "vint-i-un mil"

I18n.with_locale(:ca) { 1_000_000.to_words }
# => "un milió"

I18n.with_locale(:ca) { 3_000_000_000.to_words }
# => "tres mil milions"

I18n.with_locale(:ca) { [1, 2, 3].to_words }
# => ["u", "dos", "tres"]
```

## Decimals

Decimals are read with `coma` followed by the fractional part: up to three decimal places as a number after one `zero` for each leading zero, and longer ones digit by digit. Unicode CLDR reads each digit.

```ruby
I18n.with_locale(:ca) { 3.14.to_words }
# => "tres coma catorze"

I18n.with_locale(:ca) { 21.05.to_words }
# => "vint-i-u coma zero cinc"

I18n.with_locale(:ca) { 3.1416.to_words }
# => "tres coma u quatre u sis"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:ca) { 0.1.to_words(precision: 2) }
# => "zero coma deu"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ca) { 21.77.to_words(micro_separator: 'punt') }
# => "vint-i-u punt setanta-set"
```

### Gender

The `gender` option takes `:male` (default) or `:female`. The feminine takes una and dues, also in compounds (vint-i-una, cent dues), and the feminine hundreds (dues-centes). The count of mil agrees too (dues mil, vint-i-una mil, dues-centes mil), while milió and the larger scale words count in the masculine (dos milions). Unicode CLDR counts mil and the hundreds in the masculine.

```ruby
I18n.with_locale(:ca) { 1.to_words(gender: :male) }
# => "u"

I18n.with_locale(:ca) { 21.to_words(gender: :female) }
# => "vint-i-una"

I18n.with_locale(:ca) { 2_200.to_words(gender: :female) }
# => "dues mil dues-centes"
```

### Ordinal

The `ordinal: true` option makes the last word ordinal: primer, segon, tercer and quart alone, and -è from cinquè (desè, vintè, centè, milè). A compound ends in unè, dosè, tresè and quatrè (vint-i-unè, cent dosè), where Unicode CLDR keeps primer and segon (vint-i-primer). A count of one is left out before a scale word alone (milionè). With `gender: :female` the ordinals end in -ena (primera, cinquena, vint-i-unena). As in Unicode CLDR, the counts inside a feminine ordinal stay masculine (dos-centena). Ordinals are spelled up to the largest cardinal.

```ruby
I18n.with_locale(:ca) { 1.to_words(ordinal: true) }
# => "primer"

I18n.with_locale(:ca) { 21.to_words(ordinal: true) }
# => "vint-i-unè"

I18n.with_locale(:ca) { 2_000.to_words(ordinal: true) }
# => "dos milè"

I18n.with_locale(:ca) { 1_000_000.to_words(ordinal: true) }
# => "milionè"

I18n.with_locale(:ca) { 21.to_words(ordinal: true, gender: :female) }
# => "vint-i-unena"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part and keeps coma.

```ruby
I18n.with_locale(:ca) { 0.7.to_words(remove_zero: true) }
# => "coma set"
```

## Sources

- [Institut d'Estudis Catalans: Ortografia catalana](https://www.iec.cat/llengua/documents/ortografia_catalana_versio_digital.pdf): The spelling standard, including the hyphenation of numerals (vint-i-u, dos-cents, cent vint).
- [Universitat de Barcelona: Llibre d'estil, Numerals](https://www.ub.edu/llibre-estil/criteri_bloc.php?id=308): Hyphens between tens and units and between units and hundreds, also in ordinals.
- [Omniglot: Catalan Numbers](https://www.omniglot.com/language/numbers/catalan.htm): Cardinals, the feminine forms and ordinals such as vint-i-unè.
- [Unicode CLDR: Catalan Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/ca.xml): The spell-out rules ICU uses to write numbers in words.
