# Welsh (`cy`)

Cymraeg. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers are read in the decimal system, as Unicode CLDR reads them and as Welsh is taught ("dau ddeg un"), with the mutations of a scale word after the count's last digit: dau softens it ("dau gant", "dau filiwn" for two billion), tri and chwe aspirate c, p and t ("tri chant", "chwe thriliwn"), and mil and miliwn are feminine, softened after un and counted with dwy, tair and pedair ("dwy fil", "tair miliwn"). One hundred, one thousand and one million are "cant", "mil" and "miliwn" alone, ten is "deg", and cant is "can" before a scale word ("can mil"). Welsh uses the short scale: miliwn, biliwn, triliwn. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Unicode CLDR stops at kwadriliwn (10<sup>15</sup>); the gem writes it cwadriliwn, as Welsh spells a k sound, and cwintiliwn, secstiliwn, septiliwn, octiliwn, noniliwn and desiliwn (10<sup>18</sup> to 10<sup>33</sup>) follow its pattern and need native-speaker review, as does treating them as masculine like biliwn ("dau gwadriliwn").

Unicode CLDR also reads one hundred as "un cant", ten as "un deg" and leaves the counted scale words unmutated and masculine ("dau cant", "dau mil"); the gem follows the grammars, see [cldr_rules.yml](../../spec/fixtures/cldr_rules.yml). Numbers are joined without "a" or commas, as in CLDR.

## Examples

```ruby
I18n.with_locale(:cy) { 0.to_words }
# => "dim"

I18n.with_locale(:cy) { 21.to_words }
# => "dau ddeg un"

I18n.with_locale(:cy) { 300.to_words }
# => "tri chant"

I18n.with_locale(:cy) { 2_000.to_words }
# => "dwy fil"

I18n.with_locale(:cy) { 123_456.to_words }
# => "cant dau ddeg tair mil pedwar cant pum deg chwech"

I18n.with_locale(:cy) { 2_000_000_000.to_words }
# => "dau filiwn"

I18n.with_locale(:cy) { [1, 2, 3].to_words }
# => ["un", "dau", "tri"]
```

## Decimals

Decimals are read with pwynt and then each fractional digit, including leading zeros, as Unicode CLDR reads them. The digits are masculine also with `gender: :female`, which only changes the integral part.

```ruby
I18n.with_locale(:cy) { 3.14.to_words }
# => "tri pwynt un pedwar"

I18n.with_locale(:cy) { 21.05.to_words }
# => "dau ddeg un pwynt dim pump"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:cy) { 1.5.to_words(precision: 3) }
# => "un pwynt pump dim dim"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:cy) { 21.77.to_words(micro_separator: "coma") }
# => "dau ddeg un coma saith saith"
```

### Gender

`gender:` is `:male` (the default) or `:female`, the gender of what is counted: a final two, three or four is dwy, tair or pedair. The counts of scale words take the gender of the scale word ("dwy fil", "dau filiwn").

```ruby
I18n.with_locale(:cy) { 2.to_words(gender: :female) }
# => "dwy"

I18n.with_locale(:cy) { 22.to_words(gender: :female) }
# => "dau ddeg dwy"

I18n.with_locale(:cy) { 3.to_words(gender: :male) }
# => "tri"
```

### Vigesimal

`vigesimal: true` reads the traditional system, which counts in twenties below a hundred ("un ar hugain", "deg a thrigain"), with deuddeg, pymtheg, deunaw and hanner cant, "a" or "ac" before a last part below a hundred ("cant ac un", "mil a phump"), and a scale word after the first part of its count ("un fil ar hugain"). Unicode CLDR has no vigesimal Welsh rules.

```ruby
I18n.with_locale(:cy) { 21.to_words(vigesimal: true) }
# => "un ar hugain"

I18n.with_locale(:cy) { 70.to_words(vigesimal: true) }
# => "deg a thrigain"

I18n.with_locale(:cy) { 123.to_words(vigesimal: true) }
# => "cant a thri ar hugain"

I18n.with_locale(:cy) { 21_000.to_words(vigesimal: true) }
# => "un fil ar hugain"

I18n.with_locale(:cy) { 17.to_words(vigesimal: true, gender: :female) }
# => "dwy ar bymtheg"
```

### Ordinal

`ordinal: true` spells the traditional ordinals, with or without `vigesimal: true`, as Welsh has no decimal ordinals in standard use: "unfed ar hugain", "deugeinfed", "hanner canfed". Above a hundred the first part of the number takes the ordinal ending, the hundreds or the leading scale word ("canfed", "dau ganfed", "dwy filfed", "miliynfed"), and the rest follows as a traditional cardinal ("canfed ac un"); grammars give no compound ordinals above a hundred, so these need native-speaker review. `gender: :female` gives trydedd, pedwaredd and pedair ugeinfed. Ordinals start at 1; Welsh has no ordinal of zero. Unicode CLDR has no Welsh ordinals.

```ruby
I18n.with_locale(:cy) { 1.to_words(ordinal: true) }
# => "cyntaf"

I18n.with_locale(:cy) { 21.to_words(ordinal: true) }
# => "unfed ar hugain"

I18n.with_locale(:cy) { 3.to_words(ordinal: true, gender: :female) }
# => "trydedd"

I18n.with_locale(:cy) { 101.to_words(ordinal: true) }
# => "canfed ac un"

I18n.with_locale(:cy) { 2_000.to_words(ordinal: true) }
# => "dwy filfed"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps pwynt.

```ruby
I18n.with_locale(:cy) { 0.7.to_words(remove_zero: true) }
# => "pwynt saith"
```

## Sources

- [Wikipedia: Welsh Numerals](https://en.wikipedia.org/wiki/Welsh_numerals): Decimal and vigesimal cardinals, the gender of mil, miliwn and biliwn, mutations after numbers, and ordinals up to biliynfed.
- [Clwb Malu Cachu: Numbers, Ordinals](https://clwbmalucachu.co.uk/blog/knowledge-base/numbers-ordinals/): Compound ordinals take the ordinal ending on their first part.
- [Unicode CLDR: Welsh Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/cy.xml): The spell-out rules ICU uses to write numbers in words.
- [Unicode CLDR: Plural Rules](https://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html): The zero, one, two, few, many and other categories, which match the mutations after a number.
