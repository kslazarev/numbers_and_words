# Turkish (`tr`)

Türkçe is the Turkish name of the language. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:tr) { 0.to_words }
# => "sıfır"

I18n.with_locale(:tr) { 21.to_words }
# => "yirmi bir"

I18n.with_locale(:tr) { 231.to_words }
# => "iki yüz otuz bir"

I18n.with_locale(:tr) { 4030.to_words }
# => "dört bin otuz"

I18n.with_locale(:tr) { 1_000_100.to_words }
# => "bir milyon yüz"

I18n.with_locale(:tr) { 2_000_000_000.to_words }
# => "iki milyar"

I18n.with_locale(:tr) { [1, 2, 3].to_words }
# => ["bir", "iki", "üç"]

I18n.with_locale(:tr) { [11, 22, 133].to_words }
# => ["on bir", "yirmi iki", "yüz otuz üç"]
```

## Decimals

Decimals are read with virgül followed by each fractional digit, including leading zeros, as in Unicode CLDR.

```ruby
I18n.with_locale(:tr) { 3.14.to_words }
# => "üç virgül bir dört"

I18n.with_locale(:tr) { 21.05.to_words }
# => "yirmi bir virgül sıfır beş"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:tr) { 0.1.to_words(precision: 2) }
# => "sıfır virgül bir sıfır"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:tr) { 21.77.to_words(micro_separator: 'nokta') }
# => "yirmi bir nokta yedi yedi"
```

### Ordinal

The `ordinal: true` option adds -inci to the last word, following vowel harmony ("yirmi birinci", "dokuzuncu").

```ruby
I18n.with_locale(:tr) { 1.to_words(ordinal: true) }
# => "birinci"

I18n.with_locale(:tr) { 21.to_words(ordinal: true) }
# => "yirmi birinci"

I18n.with_locale(:tr) { 2_000.to_words(ordinal: true) }
# => "iki bininci"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part and keeps virgül.

```ruby
I18n.with_locale(:tr) { 0.7.to_words(remove_zero: true) }
# => "virgül yedi"
```

## Sources

- [TDK: Writing Numbers](https://tdk.gov.tr/icerik/yazim-kurallari/sayilarin-yazilisi/): Official Turkish numeral spelling rules.
- [Omniglot: Turkish Numbers](https://www.omniglot.com/language/numbers/turkish.htm): Cardinal and ordinal forms.
- [Vikisözlük: milyonuncu](https://tr.wiktionary.org/wiki/milyonuncu): The millionth ordinal.
- [Unicode CLDR: Turkish Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/tr.xml): The spell-out rules ICU uses to write numbers in words.
