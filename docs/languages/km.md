# Khmer (`km`)

ភាសាខ្មែរ is the Khmer name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are written without spaces. Khmer numbers have no gender.

The tens have their own words (ដប់, ម្ភៃ, សាមសិប, សែសិប, ហាសិប, ហុកសិប, ចិតសិប, ប៉ែតសិប, កៅសិប), and six to nine are counted from five (ប្រាំមួយ, ប្រាំពីរ, ប្រាំបី, ប្រាំបួន). Each group of up to six digits uses the places រយ (100), ពាន់ (1,000), ម៉ឺន (10,000) and សែន (100,000). លាន (1,000,000) repeats for larger numbers, so 10<sup>9</sup> is មួយពាន់លាន and 10<sup>12</sup> is មួយលានលាន; there is no limit.

Ten million is ដប់លាន, as in the Unicode CLDR rules, rather than មួយកោដិ, which some areas use for a billion. The CLDR rules stop at 10<sup>12</sup> and read 10<sup>10</sup> to 10<sup>12</sup> with កោដិ (10<sup>7</sup>), as មួយពាន់កោដិ. The gem continues with លាន, as in current usage (10<sup>10</sup> is មួយម៉ឺនលាន). The readings from 10<sup>12</sup> on, past CLDR, need a native speaker's review. So do the loanwords ប៊ីលាន (billion) and ទ្រីលាន (trillion), which the gem doesn't use.

## Examples

```ruby
I18n.with_locale(:km) { 0.to_words }
# => "សូន្យ"

I18n.with_locale(:km) { 21.to_words }
# => "ម្ភៃមួយ"

I18n.with_locale(:km) { 99.to_words }
# => "កៅសិបប្រាំបួន"

I18n.with_locale(:km) { 123_456.to_words }
# => "មួយសែនពីរម៉ឺនបីពាន់បួនរយហាសិបប្រាំមួយ"

I18n.with_locale(:km) { 21_000_000.to_words }
# => "ម្ភៃមួយលាន"

I18n.with_locale(:km) { 1_000_000_000.to_words }
# => "មួយពាន់លាន"

I18n.with_locale(:km) { 1_000_000_000_000.to_words }
# => "មួយលានលាន"

I18n.with_locale(:km) { -5.to_words }
# => "ដកប្រាំ"

I18n.with_locale(:km) { [11, 22, 133].to_words }
# => ["ដប់មួយ", "ម្ភៃពីរ", "មួយរយសាមសិបបី"]
```

## Decimals

Decimals are read with ចុច followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:km) { 3.14.to_words }
# => "បីចុចមួយបួន"

I18n.with_locale(:km) { 21.05.to_words }
# => "ម្ភៃមួយចុចសូន្យប្រាំ"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:km) { 0.1.to_words(precision: 2) }
# => "សូន្យចុចមួយសូន្យ"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:km) { 21.77.to_words(micro_separator: "plus") }
# => "ម្ភៃមួយplusប្រាំពីរប្រាំពីរ"
```

### Ordinal

With `ordinal: true`, the prefix ទី is added to integers of any size.

```ruby
I18n.with_locale(:km) { 1.to_words(ordinal: true) }
# => "ទីមួយ"

I18n.with_locale(:km) { 21.to_words(ordinal: true) }
# => "ទីម្ភៃមួយ"
```

### Remove Zero

With `remove_zero: true`, a zero integral part is omitted.

```ruby
I18n.with_locale(:km) { 0.7.to_words(remove_zero: true) }
# => "ចុចប្រាំពីរ"
```

## Sources

- [Wikipedia: Khmer Numerals](https://en.wikipedia.org/wiki/Khmer_numerals): Numerals, tens, places and large numbers.
- [Unicode CLDR: Khmer Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/km.xml): The spell-out rules ICU uses to write numbers in words.
