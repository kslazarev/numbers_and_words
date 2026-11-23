# Maltese (`mt`)

Malti. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers use the independent forms, said alone (tnejn, tlieta, għaxra), as Unicode CLDR's spellout-numbering does. The forms before a noun (żewġ, tliet, għaxar) aren't supported. Only one has a feminine (wieħed, waħda); see [Gender](#gender). "U" joins every part, with the ones before the tens (wieħed u għoxrin, elf u mija u wieħed).

As with any Maltese noun, a scale word's form depends on the last two digits of its count:

- One: the word alone (elf, miljun).
- Two: the dual or żewġ (elfejn, żewġ miljuni).
- Three to ten: the plural, after the form before a noun (tlitt elef, tliet miljuni, mija u tlitt elef).
- Eleven to nineteen: the singular, after the form in -il (ħdax-il elf).
- Any other count: the singular (għoxrin elf, mitt elf, tliet mitt elf).

The ones of a compound count above twenty are independent (tlieta u għoxrin elf), where CLDR has the form before a noun (tliet u għoxrin elf). Scale words follow the short scale: biljun (10<sup>9</sup>), triljun (10<sup>12</sup>) and kvadriljun (10<sup>15</sup>), as in Unicode CLDR. Kvintiljun (10<sup>18</sup>), sestiljun, settiljun, ottiljun, noniljun and deċiljun (10<sup>33</sup>) follow the same pattern and need a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Words are written with the ASCII apostrophe (erba', disa'), as in Maltese orthography. Unicode CLDR uses the modifier letter apostrophe (ʼ).

## Examples

```ruby
I18n.with_locale(:mt) { 0.to_words }
# => "żero"

I18n.with_locale(:mt) { 21.to_words }
# => "wieħed u għoxrin"

I18n.with_locale(:mt) { 231.to_words }
# => "mitejn u wieħed u tletin"

I18n.with_locale(:mt) { 3000.to_words }
# => "tlitt elef"

I18n.with_locale(:mt) { 11_000.to_words }
# => "ħdax-il elf"

I18n.with_locale(:mt) { 123_456.to_words }
# => "mija u tlieta u għoxrin elf u erba' mija u sitta u ħamsin"

I18n.with_locale(:mt) { 2_000_000.to_words }
# => "żewġ miljuni"

I18n.with_locale(:mt) { 300_000_000.to_words }
# => "tliet mitt miljun"

I18n.with_locale(:mt) { [1, 2, 3].to_words }
# => ["wieħed", "tnejn", "tlieta"]

I18n.with_locale(:mt) { [11, 22, 133].to_words }
# => ["ħdax", "tnejn u għoxrin", "mija u tlieta u tletin"]
```

## Decimals

Decimals are read with punt followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:mt) { 3.14.to_words }
# => "tlieta punt wieħed erbgħa"

I18n.with_locale(:mt) { 21.05.to_words }
# => "wieħed u għoxrin punt żero ħamsa"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:mt) { 0.1.to_words(precision: 2) }
# => "żero punt wieħed żero"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:mt) { 21.77.to_words(micro_separator: "virgola") }
# => "wieħed u għoxrin virgola sebgħa sebgħa"
```

### Gender

`gender: :male` (default, wieħed) or `gender: :female` (waħda) sets the gender of a one in the last part of a number. The counts of scale words stay masculine (wieħed u għoxrin elf).

```ruby
I18n.with_locale(:mt) { 1.to_words(gender: :male) }
# => "wieħed"

I18n.with_locale(:mt) { 21.to_words(gender: :female) }
# => "waħda u għoxrin"

I18n.with_locale(:mt) { 1001.to_words(gender: :female) }
# => "elf u waħda"
```

### Ordinal

`ordinal: true` gives the ordinals of one to ten (ewwel, tieni, tielet, raba', ħames, sitt, seba', tmien, disa', għaxar), which don't change with gender. Above ten, and for zero, Maltese uses the cardinal in the requested gender (ħdax, wieħed u għoxrin, waħda u għoxrin). Maltese puts the definite article before ordinals, assimilated to the next letter (l-ewwel, it-tieni, il-ħdax-il); the gem leaves it out. The forms before a noun (il-ħdax-il darba) aren't supported.

```ruby
I18n.with_locale(:mt) { 1.to_words(ordinal: true) }
# => "ewwel"

I18n.with_locale(:mt) { 4.to_words(ordinal: true) }
# => "raba'"

I18n.with_locale(:mt) { 21.to_words(ordinal: true, gender: :female) }
# => "waħda u għoxrin"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps punt.

```ruby
I18n.with_locale(:mt) { 0.7.to_words(remove_zero: true) }
# => "punt sebgħa"
```

## Sources

- [Lucas and Spagnol: Connecting /t/ in Maltese Numerals](https://eprints.soas.ac.uk/21964/): The independent forms of two to ten (tnejn, tlieta) and the forms before a noun, with and without a connecting t (tliet, tlitt).
- [Unicode CLDR: Maltese Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/mt.xml): The spell-out rules ICU uses to write numbers in words.
- [Unicode CLDR: Plural Rules](https://github.com/unicode-org/cldr/blob/main/common/supplemental/plurals.xml): The Maltese plural categories by the last two digits of a count.
