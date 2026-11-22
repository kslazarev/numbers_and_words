# English (`en`)

English. Numbers up to 10<sup>48</sup> - 1 are supported; larger numbers raise `RangeError`.

Aliases: `en-AU`, `en-CA`, `en-IN`, `en-US`.

## Examples

```ruby
I18n.with_locale(:en) { 0.to_words }
# => "zero"

I18n.with_locale(:en) { 21.to_words }
# => "twenty-one"

I18n.with_locale(:en) { 231.to_words }
# => "two hundred thirty-one"

I18n.with_locale(:en) { 4030.to_words }
# => "four thousand thirty"

I18n.with_locale(:en) { 1_000_100.to_words }
# => "one million one hundred"

I18n.with_locale(:en) { 2_000_000_000.to_words }
# => "two billion"

I18n.with_locale(:en) { [1, 2, 3].to_words }
# => ["one", "two", "three"]

I18n.with_locale(:en) { [11, 22, 133].to_words }
# => ["eleven", "twenty-two", "one hundred thirty-three"]
```

## Decimals

Decimals are read as a fraction, or with `point` with `fraction: false` (see [Fraction](#fraction)), which 2.0 will make the default.

```ruby
I18n.with_locale(:en) { 21.77.to_words }
# => "twenty-one and seventy-seven hundredths"

I18n.with_locale(:en) { 3.05.to_words }
# => "three and five hundredths"

I18n.with_locale(:en) { 3.1416.to_words }
# => "three and one thousand four hundred sixteen ten-thousandths"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:en) { 0.1.to_words(precision: 2) }
# => "zero and ten hundredths"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:en) { 21.77.to_words(micro_separator: "plus") }
# => "twenty-one plus seventy-seven hundredths"
```

### Fraction

`fraction: true`, the default, reads decimals as a fraction. `fraction: false` reads `point` and then each fractional digit, including leading zeros. 2.0 will make `fraction: false` the default and warns about the change (see [UPGRADING](../../UPGRADING.md)).

```ruby
I18n.with_locale(:en) { 21.77.to_words(fraction: false) }
# => "twenty-one point seven seven"

I18n.with_locale(:en) { 3.05.to_words(fraction: false) }
# => "three point zero five"

I18n.with_locale(:en) { 3.1416.to_words(fraction: false) }
# => "three point one four one six"
```

### Hundreds With Union

`hundreds_with_union: true` adds "and" after hundreds.

```ruby
I18n.with_locale(:en) { 111.to_words(hundreds_with_union: true) }
# => "one hundred and eleven"
```

### Ordinal

`ordinal: true`

```ruby
I18n.with_locale(:en) { 21.to_words(ordinal: true) }
# => "twenty-first"

I18n.with_locale(:en) { 133.to_words(ordinal: true) }
# => "one hundred thirty-third"
```

### Pronounced

`pronounced: true` reads numbers of up to four digits in pairs, as usually spoken. Longer numbers are read as usual.

```ruby
I18n.with_locale(:en) { 1984.to_words(pronounced: true) }
# => "nineteen eighty-four"

I18n.with_locale(:en) { 1101.to_words(pronounced: true) }
# => "eleven oh one"

I18n.with_locale(:en) { 12_345.to_words(pronounced: true) }
# => "twelve thousand three hundred forty-five"
```

### Remove Hyphen

`remove_hyphen: true` removes the hyphen between tens and ones.

```ruby
I18n.with_locale(:en) { 21.to_words(remove_hyphen: true) }
# => "twenty one"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:en) { 0.7.to_words(remove_zero: true) }
# => "seven tenths"

I18n.with_locale(:en) { [0.1, 0.31, 0.12].to_words(remove_zero: true) }
# => ["one tenth", "thirty-one hundredths", "twelve hundredths"]
```

## Sources

- [Cambridge Grammar: Number](https://dictionary.cambridge.org/grammar/british-grammar/number): Cardinal and ordinal usage, including regional conventions.
- [OpenStax: Decimals](https://openstax.org/books/prealgebra-2e/pages/5-1-decimals): Decimal place values and fraction-based readings.
- [Merriam-Webster: quattuordecillion](https://www.merriam-webster.com/dictionary/quattuordecillion): A large short-scale number name.
- [Unicode CLDR: English Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/en.xml): The spell-out rules ICU uses to write numbers in words.
