# Hindi (`hi`)

हिन्दी. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are written in Devanagari and separated by spaces.

Hindi uses the Indian numbering system. Every number from 0 to 99 is its own word (इक्कीस, अठहत्तर, निन्यानबे) and is not composed from tens and ones. The last three digits are read as hundreds (छह सौ अठहत्तर), and each scale above them counts from 1 to 99: हज़ार (10^3), लाख (10^5), करोड़ (10^7), अरब (10^9) and खरब (10^11), so 1,23,45,678 is एक करोड़ तेईस लाख पैंतालीस हज़ार छह सौ अठहत्तर. Larger numbers repeat खरब with its count spelled the same way (10^13 is एक सौ खरब, 10^18 is एक करोड़ खरब) rather than using the rare names नील, पद्म and शंख. 100 and 1,000 are एक सौ and एक हज़ार.

## Examples

```ruby
I18n.with_locale(:hi) { 0.to_words }
# => "शून्य"

I18n.with_locale(:hi) { 21.to_words }
# => "इक्कीस"

I18n.with_locale(:hi) { 78.to_words }
# => "अठहत्तर"

I18n.with_locale(:hi) { 231.to_words }
# => "दो सौ इकतीस"

I18n.with_locale(:hi) { 4030.to_words }
# => "चार हज़ार तीस"

I18n.with_locale(:hi) { 123_456.to_words }
# => "एक लाख तेईस हज़ार चार सौ छप्पन"

I18n.with_locale(:hi) { 12_345_678.to_words }
# => "एक करोड़ तेईस लाख पैंतालीस हज़ार छह सौ अठहत्तर"

I18n.with_locale(:hi) { 2_000_000_000.to_words }
# => "दो अरब"

I18n.with_locale(:hi) { [1, 2, 3].to_words }
# => ["एक", "दो", "तीन"]

I18n.with_locale(:hi) { [11, 22, 133].to_words }
# => ["ग्यारह", "बाईस", "एक सौ तैंतीस"]
```

## Decimals

Decimals are read with दशमलव followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:hi) { 3.14.to_words }
# => "तीन दशमलव एक चार"

I18n.with_locale(:hi) { 21.05.to_words }
# => "इक्कीस दशमलव शून्य पाँच"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:hi) { 0.1.to_words(precision: 2) }
# => "शून्य दशमलव एक शून्य"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:hi) { 21.77.to_words(micro_separator: "बिंदु") }
# => "इक्कीस बिंदु सात सात"
```

### Ordinal

`ordinal: true` gives पहला, दूसरा, तीसरा, चौथा and छठा for 1, 2, 3, 4 and 6, and adds वाँ to the cardinal otherwise (पाँचवाँ, इक्कीसवाँ, एक सौवाँ). The irregular forms are used only for the numbers themselves; larger numbers ending in them add वाँ (101 is एक सौ एकवाँ). Decimals keep the cardinal form.

```ruby
I18n.with_locale(:hi) { 1.to_words(ordinal: true) }
# => "पहला"

I18n.with_locale(:hi) { 5.to_words(ordinal: true) }
# => "पाँचवाँ"

I18n.with_locale(:hi) { 21.to_words(ordinal: true) }
# => "इक्कीसवाँ"

I18n.with_locale(:hi) { 100.to_words(ordinal: true) }
# => "एक सौवाँ"
```

### Gender

`gender: :male` (the default) or `gender: :female`, the gender of an ordinal: पहली, दूसरी, छठी, and वीं instead of वाँ. Cardinals do not change.

```ruby
I18n.with_locale(:hi) { 1.to_words(ordinal: true, gender: :female) }
# => "पहली"

I18n.with_locale(:hi) { 5.to_words(ordinal: true, gender: :female) }
# => "पाँचवीं"

I18n.with_locale(:hi) { 2.to_words(ordinal: true, gender: :male) }
# => "दूसरा"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps दशमलव.

```ruby
I18n.with_locale(:hi) { 0.7.to_words(remove_zero: true) }
# => "दशमलव सात"
```

## Sources

- [Wiktionary: बानबे](https://hi.wiktionary.org/wiki/बानबे): A dictionary spelling of ninety-two.
- [Hindwi Dictionary: छिहत्तर](https://www.hindwidictionary.com/meaning-of-chhihattar): A dictionary spelling of seventy-six.
- [Unicode CLDR: Hindi Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/hi.xml): The spell-out rules ICU uses to write numbers in words.
