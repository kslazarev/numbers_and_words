# Albanian (`sq`)

Shqip. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

"e" joins each part after the first (njëzet e një, njëqind e dhjetë, një mijë e një). Teens are the unit and mbëdhjetë (njëmbëdhjetë, trembëdhjetë). Hundreds are one word with their count (njëqind, dyqind). Three is tre, or tri in the feminine; see [Gender](#gender). As in Unicode CLDR, mijë counts in the masculine (tre mijë), and milion and the larger scale words, with the plural -ë, in the feminine (tri milionë). Scales follow the long scale: milion (10<sup>6</sup>), miliard (10<sup>9</sup>, which Unicode CLDR spells miliar), bilion, biliard, trilion, triliard, kuadrilion, kuadriliard, kuintilion and kuintiliard (10<sup>33</sup>). Unicode CLDR stops at biliard (10<sup>15</sup>); the larger names follow the same pattern and need a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:sq) { 0.to_words }
# => "zero"

I18n.with_locale(:sq) { 13.to_words }
# => "trembëdhjetë"

I18n.with_locale(:sq) { 21.to_words }
# => "njëzet e një"

I18n.with_locale(:sq) { 245.to_words }
# => "dyqind e dyzet e pesë"

I18n.with_locale(:sq) { 2_021.to_words }
# => "dy mijë e njëzet e një"

I18n.with_locale(:sq) { 1_000_000.to_words }
# => "një milion"

I18n.with_locale(:sq) { 3_000_000_000.to_words }
# => "tri miliardë"

I18n.with_locale(:sq) { [1, 2, 3].to_words }
# => ["një", "dy", "tre"]
```

## Decimals

Decimals are read with `presje` followed by each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:sq) { 3.14.to_words }
# => "tre presje një katër"

I18n.with_locale(:sq) { 21.05.to_words }
# => "njëzet e një presje zero pesë"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:sq) { 0.1.to_words(precision: 2) }
# => "zero presje një zero"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:sq) { 21.77.to_words(micro_separator: "pikë") }
# => "njëzet e një pikë shtatë shtatë"
```

### Gender

`gender: :male` (default) or `gender: :female`. Only three changes, to tri, also at the end of a compound (njëzet e tri).

```ruby
I18n.with_locale(:sq) { 3.to_words(gender: :male) }
# => "tre"

I18n.with_locale(:sq) { 23.to_words(gender: :female) }
# => "njëzet e tri"
```

### Ordinal

`ordinal: true` gives the indefinite ordinal with its article: i, or e with `gender: :female`. The last word takes -të, or -t after katër (i parë, i dytë, i katërt, i njëzetë, i njëqindtë, i një mijëtë, i një miliontë). A final one in a compound is njëtë (i njëzet e njëtë). Zero keeps its cardinal form. Ordinals are spelled up to the largest cardinal.

Unicode CLDR has no Albanian ordinals. The gem writes compounds apart, like its cardinals (i njëzet e njëtë), though they are also written as one word (i njëzetenjëtë). It does not decline the article or give the definite forms (i pari).

```ruby
I18n.with_locale(:sq) { 1.to_words(ordinal: true) }
# => "i parë"

I18n.with_locale(:sq) { 21.to_words(ordinal: true) }
# => "i njëzet e njëtë"

I18n.with_locale(:sq) { 100.to_words(ordinal: true) }
# => "i njëqindtë"

I18n.with_locale(:sq) { 2.to_words(ordinal: true, gender: :female) }
# => "e dytë"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps presje.

```ruby
I18n.with_locale(:sq) { 0.7.to_words(remove_zero: true) }
# => "presje shtatë"
```

## Sources

- [Wiktionary: Albanische Zahlen](https://de.wiktionary.org/wiki/Verzeichnis:Albanisch/Zahlen): Cardinals, the feminine tri, and ordinals from i parë to i një miliontë.
- [Omniglot: Albanian Numbers](https://omniglot.com/language/numbers/albanian.htm): Cardinals and ordinal articles.
- [Unicode CLDR: Albanian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/sq.xml): The spell-out rules ICU uses to write numbers in words.
