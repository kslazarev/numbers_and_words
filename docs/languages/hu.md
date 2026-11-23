# Hungarian (`hu`)

Magyar is the Hungarian name of the language. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:hu) { 0.to_words }
# => "nulla"

I18n.with_locale(:hu) { 21.to_words }
# => "huszonegy"

I18n.with_locale(:hu) { 231.to_words }
# => "kétszázharmincegy"

I18n.with_locale(:hu) { 4030.to_words }
# => "négyezer-harminc"

I18n.with_locale(:hu) { 1_000_100.to_words }
# => "egymillió-száz"

I18n.with_locale(:hu) { 2_000_000_000.to_words }
# => "kétmilliárd"

I18n.with_locale(:hu) { [1, 2, 3].to_words }
# => ["egy", "kettő", "három"]

I18n.with_locale(:hu) { [11, 22, 133].to_words }
# => ["tizenegy", "huszonkettő", "százharminchárom"]
```

## Decimals

Decimals are read as the integral part, `egész`, and a count of tized, század, ezred and so on. Both parts are in the form used before a noun, so a final two is két.

```ruby
I18n.with_locale(:hu) { 2.2.to_words }
# => "két egész két tized"

I18n.with_locale(:hu) { 21.77.to_words }
# => "huszonegy egész hetvenhét század"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:hu) { 0.1.to_words(precision: 2) }
# => "nulla egész tíz század"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:hu) { 21.77.to_words(micro_separator: "plus") }
# => "huszonegy plus hetvenhét század"
```

### Ordinal

With `ordinal: true`, első and második are used only for 1 and 2 alone. Compounds use egyedik and kettedik ("százegyedik", "ezeregyedik"). The millionth is milliomodik, although egymilliomodik is also valid. Compounds keep egy ("egymillió-egyedik").

```ruby
I18n.with_locale(:hu) { 21.to_words(ordinal: true) }
# => "huszonegyedik"

I18n.with_locale(:hu) { 101.to_words(ordinal: true) }
# => "százegyedik"

I18n.with_locale(:hu) { 1_001.to_words(ordinal: true) }
# => "ezeregyedik"

I18n.with_locale(:hu) { 1_000_000.to_words(ordinal: true) }
# => "milliomodik"
```

### Remove Zero

With `remove_zero: true`, a zero integral part is omitted.

```ruby
I18n.with_locale(:hu) { 0.7.to_words(remove_zero: true) }
# => "hét tized"
```

## Sources

- [Hungarian Academy: Numeral Orthography](https://helyesiras.mta.hu/helyesiras/default/akh12#291): Numeral joining and hyphenation.
- [Hungarian Academy: Numeral Converter](https://helyesiras.mta.hu/helyesiras/default/numerals?q=101.): Compound ordinal examples.
- [Nyelv és Tudomány: Ordinal Analogies](https://www.nyest.hu/hirek/analogia-a-magyar-sorszamnevekben): Ordinal stems and forms such as milliomodik.
- [Unicode CLDR: Hungarian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/hu.xml): The spell-out rules ICU uses to write numbers in words.
