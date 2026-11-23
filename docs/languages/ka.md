# Georgian (`ka`)

ქართული. Scale words are ათასი, მილიონი, მილიარდი and ტრილიონი. A scale word drops its final ი when any lower group follows, including another scale group ("ერთი მილიონ ათასი"). Numbers up to 10<sup>15</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:ka) { 0.to_words }
# => "ნული"

I18n.with_locale(:ka) { 21.to_words }
# => "ოცდაერთი"

I18n.with_locale(:ka) { 231.to_words }
# => "ორას ოცდათერთმეტი"

I18n.with_locale(:ka) { 4030.to_words }
# => "ოთხი ათას ოცდაათი"

I18n.with_locale(:ka) { 1_000_100.to_words }
# => "ერთი მილიონ ასი"

I18n.with_locale(:ka) { 1_001_000.to_words }
# => "ერთი მილიონ ათასი"

I18n.with_locale(:ka) { 2_000_000_000.to_words }
# => "ორი მილიარდი"

I18n.with_locale(:ka) { [1, 2, 3].to_words }
# => ["ერთი", "ორი", "სამი"]

I18n.with_locale(:ka) { [11, 22, 133].to_words }
# => ["თერთმეტი", "ოცდაორი", "ას ოცდაცამეტი"]
```

## Decimals

Decimals are read with მძიმე and then each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:ka) { 3.14.to_words }
# => "სამი მძიმე ერთი ოთხი"

I18n.with_locale(:ka) { 21.05.to_words }
# => "ოცდაერთი მძიმე ნული ხუთი"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:ka) { 0.1.to_words(precision: 2) }
# => "ნული მძიმე ერთი ნული"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ka) { 21.77.to_words(micro_separator: "წერტილი") }
# => "ოცდაერთი წერტილი შვიდი შვიდი"
```

### Ordinal

`ordinal: true` gives პირველი for 1, and otherwise adds მე- and -ე to the last word, or to the last part of a compound ("ოცდამეერთე"). Of round thousands and larger scales, only the ordinal of one is supported (მეათასე, მემილიონე); others, such as 2,000, raise `RangeError` until a native speaker confirms their form. Ordinals are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:ka) { 1.to_words(ordinal: true) }
# => "პირველი"

I18n.with_locale(:ka) { 21.to_words(ordinal: true) }
# => "ოცდამეერთე"

I18n.with_locale(:ka) { 101.to_words(ordinal: true) }
# => "ას მეერთე"

I18n.with_locale(:ka) { 1_000.to_words(ordinal: true) }
# => "მეათასე"

I18n.with_locale(:ka) { 2_021.to_words(ordinal: true) }
# => "ორი ათას ოცდამეერთე"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps მძიმე.

```ruby
I18n.with_locale(:ka) { 0.7.to_words(remove_zero: true) }
# => "მძიმე შვიდი"
```

## Sources

- [Georgian Numeral Grammar](https://ka.wikipedia.org/wiki/რიცხვითი_სახელი): Cardinal scale endings and compound ordinal formation.
- [Wiktionary: ოცდამეერთე](https://en.wiktionary.org/wiki/ოცდამეერთე): The ერთ stem in compound ordinals.
- [Unicode CLDR: Georgian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/ka.xml): The spell-out rules ICU uses to write numbers in words.
