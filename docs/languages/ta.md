# Tamil (`ta`)

தமிழ். Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are in Tamil script, separated by spaces.

Tamil uses the Indian numbering system, as Unicode CLDR does: ஆயிரம் (10<sup>3</sup>), லட்சம் (10<sup>5</sup>), கோடி (10<sup>7</sup>), அரபம் (10<sup>9</sup>) and கரபம் (10<sup>11</sup>), each counting from 1 to 99. Larger numbers repeat கரபம் with its count spelled the same way (10<sup>13</sup> is நூறு கரபம், 10<sup>18</sup> is ஒரு கோடி கரபம்), so there is no largest number. Tamil news often says நூறு கோடி instead of அரபம் for 10<sup>9</sup>.

A word followed by another number takes its linking form. Tens and hundreds end in -த்து and -ற்று (இருபத்து ஒன்று, நூற்று ஒன்று), and the scales become ஆயிரத்து, லட்சத்து and கோடியே. A count joins ஆயிரம் in one word (இரண்டாயிரம், இருபத்து ஒன்றாயிரம்). One before லட்சம், கோடி and the larger scales is ஒரு (ஒரு லட்சம்). The words are the counting forms of the current CLDR rules (`spellout-numbering`); the forms used before a noun (இருபத்தொரு) aren't supported. 800 is written எண்ணூறு, with the sound change (sandhi) of ண் and ந, where CLDR writes எண்நூறு. Zero is CLDR's பூஜ்யம், not பூஜ்ஜியம் or the native சுழியம்.

## Examples

```ruby
I18n.with_locale(:ta) { 0.to_words }
# => "பூஜ்யம்"

I18n.with_locale(:ta) { 21.to_words }
# => "இருபத்து ஒன்று"

I18n.with_locale(:ta) { 101.to_words }
# => "நூற்று ஒன்று"

I18n.with_locale(:ta) { 2_021.to_words }
# => "இரண்டாயிரத்து இருபத்து ஒன்று"

I18n.with_locale(:ta) { 123_456.to_words }
# => "ஒரு லட்சத்து இருபத்து மூன்றாயிரத்து நானூற்று ஐம்பத்து ஆறு"

I18n.with_locale(:ta) { 10_000_001.to_words }
# => "ஒரு கோடியே ஒன்று"

I18n.with_locale(:ta) { 2_000_000_000.to_words }
# => "இரண்டு அரபம்"

I18n.with_locale(:ta) { [1, 2, 3].to_words }
# => ["ஒன்று", "இரண்டு", "மூன்று"]
```

## Decimals

Decimals are read with புள்ளி followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:ta) { 3.14.to_words }
# => "மூன்று புள்ளி ஒன்று நான்கு"

I18n.with_locale(:ta) { 21.05.to_words }
# => "இருபத்து ஒன்று புள்ளி பூஜ்யம் ஐந்து"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:ta) { 0.1.to_words(precision: 2) }
# => "பூஜ்யம் புள்ளி ஒன்று பூஜ்யம்"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ta) { 21.77.to_words(micro_separator: "தசம") }
# => "இருபத்து ஒன்று தசம ஏழு ஏழு"
```

### Ordinal

`ordinal: true` adds ஆவது to the last word, as CLDR does (இரண்டாவது, இருபத்து ஒன்றாவது, நூறாவது). A scale word takes it after its linking form (ஆயிரத்தாவது, ஒரு லட்சத்தாவது). The first is முதலாவது. Zero and decimals keep the cardinal form. The adjectival ordinals in -ஆம் (இரண்டாம்) aren't supported.

```ruby
I18n.with_locale(:ta) { 1.to_words(ordinal: true) }
# => "முதலாவது"

I18n.with_locale(:ta) { 21.to_words(ordinal: true) }
# => "இருபத்து ஒன்றாவது"

I18n.with_locale(:ta) { 1_000.to_words(ordinal: true) }
# => "ஆயிரத்தாவது"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps புள்ளி.

```ruby
I18n.with_locale(:ta) { 0.7.to_words(remove_zero: true) }
# => "புள்ளி ஏழு"
```

## Sources

- [Unicode CLDR: Tamil Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/ta.xml): The spell-out rules ICU uses to write numbers in words; the gem follows the current rules, which add the linking forms and sandhi that the CLDR 46.1 rules bundled with twitter_cldr lack.
- [Wikipedia: Tamil Numerals](https://en.wikipedia.org/wiki/Tamil_numerals): Numeral names, the Indian scales and ordinals.
- [Unicode Technical Note 21: Tamil Numbers](https://www.unicode.org/notes/tn21/tamil_numbers.pdf): Tamil number words and their spelling.
