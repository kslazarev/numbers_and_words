# German (`de`)

Deutsch. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Aliases: `de-AT`, `de-CH`.

## Examples

```ruby
I18n.with_locale(:de) { 0.to_words }
# => "null"

I18n.with_locale(:de) { 21.to_words }
# => "einundzwanzig"

I18n.with_locale(:de) { 231.to_words }
# => "zweihunderteinunddreißig"

I18n.with_locale(:de) { 4030.to_words }
# => "viertausenddreißig"

I18n.with_locale(:de) { 1_000_100.to_words }
# => "eine Million einhundert"

I18n.with_locale(:de) { 2_000_000_000.to_words }
# => "zwei Milliarden"

I18n.with_locale(:de) { [1, 2, 3].to_words }
# => ["eins", "zwei", "drei"]

I18n.with_locale(:de) { [11, 22, 133].to_words }
# => ["elf", "zweiundzwanzig", "einhundertdreiunddreißig"]
```

## Decimals

Decimals are read with `Komma` followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:de) { 21.77.to_words }
# => "einundzwanzig Komma sieben sieben"

I18n.with_locale(:de) { 3.05.to_words }
# => "drei Komma null fünf"

I18n.with_locale(:de) { 3.14.to_words }
# => "drei Komma eins vier"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:de) { 0.1.to_words(precision: 2) }
# => "null Komma eins null"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:de) { 21.77.to_words(micro_separator: "plus") }
# => "einundzwanzig plus sieben sieben"
```

### Ordinal

`ordinal: true` gives the uninflected `-te`/`-ste` form. Ordinals, including compounds with million or larger scales, are written as one lowercase word. Exact single scales omit the multiplier ("millionste", "milliardste"); a multiplier of two or more stays ("zweimillionste").

```ruby
I18n.with_locale(:de) { 21.to_words(ordinal: true) }
# => "einundzwanzigste"

I18n.with_locale(:de) { 101.to_words(ordinal: true) }
# => "einhunderterste"

I18n.with_locale(:de) { 2_000_000.to_words(ordinal: true) }
# => "zweimillionste"

I18n.with_locale(:de) { 1_000_000.to_words(ordinal: true) }
# => "millionste"

I18n.with_locale(:de) { 2_002_000_000.to_words(ordinal: true) }
# => "zweimilliardenzweimillionste"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:de) { 0.7.to_words(remove_zero: true) }
# => "Komma sieben"
```

## Sources

- [Duden: Joining Numerals (D65)](https://www.duden.de/sprachwissen/rechtschreibregeln/getrennt-und-zusammenschreibung#D65): Compound ordinal spelling.
- [Duden: millionste](https://www.duden.de/rechtschreibung/millionste): The bare millionth form.
- [DWDS: einmillionste](https://www.dwds.de/wb/einmillionste): An alternative form retaining the multiplier.
- [Unicode CLDR: German Number Formatting](https://github.com/unicode-org/cldr/blob/main/common/rbnf/de.xml): Cardinal and ordinal formatting rules.
