# British English (`en-GB`)

English (British). "and" joins the rest of a hundred (one hundred and one) and a final part below one hundred after thousand, million or a larger scale (one thousand and one, two million and thirty). Numbers up to 10<sup>48</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:'en-GB') { 0.to_words }
# => "zero"

I18n.with_locale(:'en-GB') { 21.to_words }
# => "twenty-one"

I18n.with_locale(:'en-GB') { 231.to_words }
# => "two hundred and thirty-one"

I18n.with_locale(:'en-GB') { 4030.to_words }
# => "four thousand and thirty"

I18n.with_locale(:'en-GB') { 2_000_001.to_words }
# => "two million and one"

I18n.with_locale(:'en-GB') { 1_000_100.to_words }
# => "one million one hundred"

I18n.with_locale(:'en-GB') { 2_000_000_000.to_words }
# => "two billion"

I18n.with_locale(:'en-GB') { [1, 2, 3].to_words }
# => ["one", "two", "three"]

I18n.with_locale(:'en-GB') { [11, 22, 133].to_words }
# => ["eleven", "twenty-two", "one hundred and thirty-three"]
```

## Decimals

Decimals are read with `point` followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:'en-GB') { 21.77.to_words }
# => "twenty-one point seven seven"

I18n.with_locale(:'en-GB') { 3.05.to_words }
# => "three point zero five"

I18n.with_locale(:'en-GB') { 3.1416.to_words }
# => "three point one four one six"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:'en-GB') { 0.1.to_words(precision: 2) }
# => "zero point one zero"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:'en-GB') { 21.77.to_words(micro_separator: "plus") }
# => "twenty-one plus seven seven"
```

### Fraction

`fraction: true` reads decimals as a fraction instead of with `point`.

```ruby
I18n.with_locale(:'en-GB') { 21.77.to_words(fraction: true) }
# => "twenty-one and seventy-seven hundredths"

I18n.with_locale(:'en-GB') { 0.1.to_words(fraction: true) }
# => "zero and one tenth"
```

### Hundreds With Union

British English adds 'and' after hundreds, and before a final part below one hundred after a larger scale, by default; `hundreds_with_union: false` omits both.

```ruby
I18n.with_locale(:'en-GB') { 111.to_words }
# => "one hundred and eleven"

I18n.with_locale(:'en-GB') { 111.to_words(hundreds_with_union: false) }
# => "one hundred eleven"

I18n.with_locale(:'en-GB') { 1001.to_words(hundreds_with_union: false) }
# => "one thousand one"
```

### Ordinal

`ordinal: true`

```ruby
I18n.with_locale(:'en-GB') { 133.to_words(ordinal: true) }
# => "one hundred and thirty-third"

I18n.with_locale(:'en-GB') { 1001.to_words(ordinal: true) }
# => "one thousand and first"
```

### Pronounced

`pronounced: true` reads numbers of up to four digits in pairs, as they are usually spoken. Longer numbers are read as usual.

```ruby
I18n.with_locale(:'en-GB') { 1984.to_words(pronounced: true) }
# => "nineteen eighty-four"

I18n.with_locale(:'en-GB') { 1101.to_words(pronounced: true) }
# => "eleven oh one"

I18n.with_locale(:'en-GB') { 2005.to_words(pronounced: true) }
# => "two thousand and five"

I18n.with_locale(:'en-GB') { 12_345.to_words(pronounced: true) }
# => "twelve thousand three hundred and forty-five"
```

### Remove Hyphen

`remove_hyphen: true` removes the hyphen between tens and ones.

```ruby
I18n.with_locale(:'en-GB') { 21.to_words(remove_hyphen: true) }
# => "twenty one"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:'en-GB') { 0.7.to_words(remove_zero: true) }
# => "point seven"
```
