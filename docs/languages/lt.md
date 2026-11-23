# Lithuanian (`lt`)

Lietuvių is the Lithuanian name of the language. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

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

Decimals are read with kablelis followed by each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:lt) { 3.14.to_words }
# => "trys kablelis vienas keturi"

I18n.with_locale(:lt) { 21.05.to_words }
# => "dvidešimt vienas kablelis nulis penki"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:lt) { 0.1.to_words(precision: 2) }
# => "nulis kablelis vienas nulis"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:lt) { 21.77.to_words(micro_separator: 'taškas') }
# => "dvidešimt vienas taškas septyni septyni"
```

### Gender

The `gender` option takes `:male` (the default) or `:female`. The last group agrees with the noun, but the counts of tūkstantis and larger scale words stay masculine. Ordinals take the feminine ending.

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

With `ordinal: true`, the last word becomes ordinal ("dvidešimt pirmas"). Ordinals use the indefinite form (pirmas, dešimtas), with two exceptions. Round hundreds and thousands take their standard definite form (šimtasis, tūkstantasis), and millions and larger take -inis (milijoninis). A round hundred, thousand or larger scale is one word with the combining form of a one-word multiplier (dušimtasis, penkiatūkstantasis, dešimttūkstantasis, dumilijoninis). A multiplier of several words stays separate (dvidešimt vienas tūkstantasis). Ordinals are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:lt) { 1.to_words(ordinal: true) }
# => "pirmas"

I18n.with_locale(:lt) { 21.to_words(ordinal: true) }
# => "dvidešimt pirmas"

I18n.with_locale(:lt) { 2_000.to_words(ordinal: true) }
# => "dutūkstantasis"
```

### Remove Zero

With `remove_zero: true`, a zero integral part is omitted and kablelis is kept.

```ruby
I18n.with_locale(:lt) { 0.7.to_words(remove_zero: true) }
# => "kablelis septyni"
```

## Sources

- [Universal Lithuanian Encyclopedia: trilijonas](https://www.vle.lt/straipsnis/trilijonas/): The 10¹² scale word.
- [EdTalk: Numerals](https://edtalk.lt/blog/skaitvardis): Numeral grammar and compound ordinals.
- [Unicode CLDR: Lithuanian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/lt.xml): The spell-out rules ICU uses to write numbers in words.
