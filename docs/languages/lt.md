# Lithuanian (`lt`)

Lietuvių. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:lt) { 0.to_words }
# => "nulis"

I18n.with_locale(:lt) { 21.to_words }
# => "dvidešimt vienas"

I18n.with_locale(:lt) { 231.to_words }
# => "du šimtai trisdešimt vienas"

I18n.with_locale(:lt) { 4030.to_words }
# => "keturi tūkstančiai trisdešimt"

I18n.with_locale(:lt) { 1_000_100.to_words }
# => "vienas milijonas šimtas"

I18n.with_locale(:lt) { 2_000_000_000.to_words }
# => "du milijardai"

I18n.with_locale(:lt) { [1, 2, 3].to_words }
# => ["vienas", "du", "trys"]

I18n.with_locale(:lt) { [11, 22, 133].to_words }
# => ["vienuolika", "dvidešimt du", "šimtas trisdešimt trys"]
```

## Decimals

Decimals are read with kablelis and then each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:lt) { 3.14.to_words }
# => "trys kablelis vienas keturi"

I18n.with_locale(:lt) { 21.05.to_words }
# => "dvidešimt vienas kablelis nulis penki"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:lt) { 0.1.to_words(precision: 2) }
# => "nulis kablelis vienas nulis"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:lt) { 21.77.to_words(micro_separator: "taškas") }
# => "dvidešimt vienas taškas septyni septyni"
```

### Gender

`gender: :male` (default) or `gender: :female`. The last group agrees with the noun; the counts of tūkstantis and larger scale words stay masculine. Ordinals take the feminine ending.

```ruby
I18n.with_locale(:lt) { 1.to_words(gender: :female) }
# => "viena"

I18n.with_locale(:lt) { 21.to_words(gender: :female) }
# => "dvidešimt viena"

I18n.with_locale(:lt) { 21_001.to_words(gender: :female) }
# => "dvidešimt vienas tūkstantis viena"

I18n.with_locale(:lt) { 1.to_words(ordinal: true, gender: :female) }
# => "pirma"

I18n.with_locale(:lt) { 100.to_words(ordinal: true, gender: :female) }
# => "šimtoji"
```

### Ordinal

`ordinal: true` makes the last word ordinal ("dvidešimt pirmas"). Ordinals use the indefinite form (pirmas, dešimtas), except round hundreds and thousands, which take their standard definite form (šimtasis, tūkstantasis), and millions and larger, which take -inis (milijoninis). A round hundred, thousand or larger scale is one word with the combining form of a one-word multiplier (dušimtasis, penkiatūkstantasis, dešimttūkstantasis, dumilijoninis); a multiplier of several words stays separate (dvidešimt vienas tūkstantasis). Ordinals are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:lt) { 1.to_words(ordinal: true) }
# => "pirmas"

I18n.with_locale(:lt) { 21.to_words(ordinal: true) }
# => "dvidešimt pirmas"

I18n.with_locale(:lt) { 2_000.to_words(ordinal: true) }
# => "dutūkstantasis"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps kablelis.

```ruby
I18n.with_locale(:lt) { 0.7.to_words(remove_zero: true) }
# => "kablelis septyni"
```

## Sources

- [Universal Lithuanian Encyclopedia: trilijonas](https://www.vle.lt/straipsnis/trilijonas/): The 10¹² scale word.
- [EdTalk: Numerals](https://edtalk.lt/blog/skaitvardis): Numeral grammar and compound ordinals.
- [Unicode CLDR: Lithuanian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/lt.xml): The spell-out rules ICU uses to write numbers in words.
