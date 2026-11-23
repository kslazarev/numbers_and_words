# German (`de`)

Deutsch is the German name of the language. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

The aliases are `de-AT` and `de-CH`.

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

Decimals are read with `Komma` and then each fractional digit, including leading zeros.

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

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:de) { 0.1.to_words(precision: 2) }
# => "null Komma eins null"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:de) { 21.77.to_words(micro_separator: "plus") }
# => "einundzwanzig plus sieben sieben"
```

### Gender

With `gender: :male`, `gender: :female` or `gender: :neuter`, a final eins becomes ein or eine before its noun ("hunderteine"). Without `gender`, eins is kept. Ordinals keep their form.

```ruby
I18n.with_locale(:de) { 1.to_words(gender: :female) }
# => "eine"

I18n.with_locale(:de) { 101.to_words(gender: :female) }
# => "einhunderteine"

I18n.with_locale(:de) { 1001.to_words(gender: :female) }
# => "eintausendeine"

I18n.with_locale(:de) { 1.to_words(gender: :male) }
# => "ein"
```

### Ordinal

The `ordinal: true` option gives the uninflected `-te`/`-ste` form, written as one lowercase word, even with million or larger scales. A single scale has no multiplier ("millionste", "milliardste"); two or more keep it ("zweimillionste").

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

The `remove_zero: true` option omits a zero integral part.

```ruby
I18n.with_locale(:de) { 0.7.to_words(remove_zero: true) }
# => "Komma sieben"
```

## Sources

- [Duden: Joining Numerals (D65)](https://www.duden.de/sprachwissen/rechtschreibregeln/getrennt-und-zusammenschreibung#D65): Compound ordinal spelling.
- [Duden: millionste](https://www.duden.de/rechtschreibung/millionste): The bare millionth form.
- [DWDS: einmillionste](https://www.dwds.de/wb/einmillionste): An alternative form retaining the multiplier.
- [Unicode CLDR: German Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/de.xml): The spell-out rules ICU uses to write numbers in words.
