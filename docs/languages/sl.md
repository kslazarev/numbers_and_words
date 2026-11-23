# Slovenian (`sl`)

Slovenščina. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

The ones come before the tens, joined by in, in one word (enaindvajset, petinštirideset). Hundreds are one word (dvesto). The parts after a hundred, tisoč or a scale word are separate words (sto ena, tisoč petsto). By default numbers take the counting forms (ena, dva, tri, štiri). Slovenian has a dual, so scale words have four forms, chosen by the last two digits of their count. Milijon and the other scale words in -ijon are masculine (en milijon, dva milijona, trije milijoni, pet milijonov, sto en milijon). Milijarda and the other scale words in -ijarda are feminine (ena milijarda, dve milijardi, tri milijarde, pet milijard). Tisoč doesn't change and has no count of one (tisoč, dva tisoč, tri tisoč). Scale words follow the long scale up to kvintilijarda (10<sup>33</sup>); the names from bilijon (10<sup>12</sup>) on follow the same pattern and need a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Unicode CLDR 46.1's Slovenian spell-out rules use Croatian words (dvaset ena, tisuću, milijun), so Slovenian isn't compared with CLDR.

## Examples

```ruby
I18n.with_locale(:sl) { 0.to_words }
# => "nič"

I18n.with_locale(:sl) { 21.to_words }
# => "enaindvajset"

I18n.with_locale(:sl) { 1234.to_words }
# => "tisoč dvesto štiriintrideset"

I18n.with_locale(:sl) { 3000.to_words }
# => "tri tisoč"

I18n.with_locale(:sl) { 3_000_000.to_words }
# => "trije milijoni"

I18n.with_locale(:sl) { 2_000_000_000.to_words }
# => "dve milijardi"

I18n.with_locale(:sl) { [11, 22, 133].to_words }
# => ["enajst", "dvaindvajset", "sto triintrideset"]
```

## Decimals

Decimals are read as a feminine whole number with cela, celi, cele or celih, followed by a feminine number of desetinke, stotinke or tisočinke (ena desetinka, dve desetinki, tri desetinke, pet desetink). This reading needs a native speaker's review. Up to eleven fractional digits are supported; more raise `RangeError`.

```ruby
I18n.with_locale(:sl) { 1.5.to_words }
# => "ena cela pet desetink"

I18n.with_locale(:sl) { 2.2.to_words }
# => "dve celi dve desetinki"

I18n.with_locale(:sl) { 3.03.to_words }
# => "tri cele tri stotinke"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:sl) { 0.1.to_words(precision: 2) }
# => "nič celih deset stotink"
```

### Micro Separator

`micro_separator` adds a word between the integral and fractional parts.

```ruby
I18n.with_locale(:sl) { 2.5.to_words(micro_separator: "in") }
# => "dve celi in pet desetink"
```

### Gender

Without `gender`, numbers take the counting forms (ena, dva, tri, štiri). `gender: :male`, `:female` or `:neuter` changes one to four at the end of the number (en, ena, eno; dva, dve, dve; trije, tri, tri; štirje, štiri, štiri). The ones in a compound such as enaindvajset don't change.

```ruby
I18n.with_locale(:sl) { 103.to_words(gender: :male) }
# => "sto trije"

I18n.with_locale(:sl) { 2.to_words(gender: :female) }
# => "dve"

I18n.with_locale(:sl) { 1.to_words(gender: :neuter) }
# => "eno"
```

### Ordinal

`ordinal: true` makes the last word ordinal (enaindvajseti, dvesto prvi), in the requested gender (prva, prvo; tretja, tretje). A round thousand or larger scale is one word with its count, which is left out when it is one (tisoči, dvatisoči, milijonti, dvamilijonti). This joined form, and the neuter tisoče, need a native speaker's review. Ordinals are spelled up to the largest number.

```ruby
I18n.with_locale(:sl) { 21.to_words(ordinal: true) }
# => "enaindvajseti"

I18n.with_locale(:sl) { 201.to_words(ordinal: true) }
# => "dvesto prvi"

I18n.with_locale(:sl) { 3.to_words(ordinal: true, gender: :neuter) }
# => "tretje"

I18n.with_locale(:sl) { 1_000_000.to_words(ordinal: true, gender: :female) }
# => "milijonta"

I18n.with_locale(:sl) { 2000.to_words(ordinal: true) }
# => "dvatisoči"
```

### Remove Zero

`remove_zero: true` omits a zero integral part; the ordinal of zero stays ničti.

```ruby
I18n.with_locale(:sl) { 0.7.to_words(remove_zero: true) }
# => "sedem desetink"
```

## Sources

- [Wikipedia: Slovene Numerals](https://en.wikipedia.org/wiki/Slovene_numerals): The gendered one to four, enaindvajset, dvesto, dva tisoč, the forms of milijon and milijarda, and the ordinals tretji, stoti, tisoči, milijonti and milijardti.
- [Unicode CLDR: Plural Rules](https://github.com/unicode-org/cldr/blob/main/common/supplemental/plurals.xml): The one, two, few and other forms of scale words and fractions.
