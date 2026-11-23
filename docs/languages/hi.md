# Hindi (`hi`)

हिन्दी is the Hindi name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are in Devanagari, separated by spaces.

Hindi uses the Indian numbering system. Each number from 0 to 99 is its own word (इक्कीस, अठहत्तर, निन्यानबे), not a compound of tens and ones. The last three digits are read as hundreds (छह सौ अठहत्तर). Each scale above them counts from 1 to 99: हज़ार (10<sup>3</sup>), लाख (10<sup>5</sup>), करोड़ (10<sup>7</sup>), अरब (10<sup>9</sup>) and खरब (10<sup>11</sup>). So 1,23,45,678 is एक करोड़ तेईस लाख पैंतालीस हज़ार छह सौ अठहत्तर. Larger numbers repeat खरब with a spelled-out count (10<sup>13</sup> is एक सौ खरब, 10<sup>18</sup> is एक करोड़ खरब), rather than the rare names नील, पद्म and शंख. 100 and 1,000 are एक सौ and एक हज़ार.

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

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:hi) { 0.1.to_words(precision: 2) }
# => "शून्य दशमलव एक शून्य"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:hi) { 21.77.to_words(micro_separator: "बिंदु") }
# => "इक्कीस बिंदु सात सात"
```

### Ordinal

With `ordinal: true`, 1, 2, 3, 4 and 6 become पहला, दूसरा, तीसरा, चौथा and छठा. Other numbers add वाँ to the cardinal (पाँचवाँ, इक्कीसवाँ, एक सौवाँ), also for larger numbers ending in 1, 2, 3, 4 or 6 (101 is एक सौ एकवाँ). Decimals keep the cardinal form.

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

With `gender: :male` (the default) or `gender: :female`, an ordinal takes that gender: पहली, दूसरी, छठी, and वीं instead of वाँ. Cardinals do not change.

```ruby
I18n.with_locale(:hi) { 1.to_words(ordinal: true, gender: :female) }
# => "पहली"

I18n.with_locale(:hi) { 5.to_words(ordinal: true, gender: :female) }
# => "पाँचवीं"

I18n.with_locale(:hi) { 2.to_words(ordinal: true, gender: :male) }
# => "दूसरा"
```

### Remove Zero

With `remove_zero: true`, a zero integral part is omitted and दशमलव is kept.

```ruby
I18n.with_locale(:hi) { 0.7.to_words(remove_zero: true) }
# => "दशमलव सात"
```

## Sources

- [Wiktionary: बानबे](https://hi.wiktionary.org/wiki/बानबे): A dictionary spelling of ninety-two.
- [Hindwi Dictionary: छिहत्तर](https://www.hindwidictionary.com/meaning-of-chhihattar): A dictionary spelling of seventy-six.
- [Unicode CLDR: Hindi Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/hi.xml): The spell-out rules ICU uses to write numbers in words.
