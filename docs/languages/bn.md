# Bengali (`bn`)

বাংলা. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are written in Bengali script and separated by spaces.

Bengali uses the Indian numbering system. Every number from 0 to 99 is its own word (একুশ, আটাত্তর, নিরানব্বই) and is not composed from tens and ones. The last three digits are read as hundreds, written as one word with শ (একশ, ছয়শ আটাত্তর), and each scale above them counts from 1 to 99: হাজার (10^3), লাখ (10^5) and কোটি (10^7), so 1,23,45,678 is এক কোটি তেইশ লাখ পঁয়তাল্লিশ হাজার ছয়শ আটাত্তর. As usual in Bengali, larger numbers repeat কোটি with its count spelled the same way: 10^9 is একশ কোটি, 10^10 is এক হাজার কোটি and 10^14 is এক কোটি কোটি; the rare names অর্বুদ and খর্ব are not used. লাখ is used rather than the more formal লক্ষ.

## Examples

```ruby
I18n.with_locale(:bn) { 0.to_words }
# => "শূন্য"

I18n.with_locale(:bn) { 21.to_words }
# => "একুশ"

I18n.with_locale(:bn) { 78.to_words }
# => "আটাত্তর"

I18n.with_locale(:bn) { 231.to_words }
# => "দুইশ একত্রিশ"

I18n.with_locale(:bn) { 4030.to_words }
# => "চার হাজার ত্রিশ"

I18n.with_locale(:bn) { 123_456.to_words }
# => "এক লাখ তেইশ হাজার চারশ ছাপ্পান্ন"

I18n.with_locale(:bn) { 12_345_678.to_words }
# => "এক কোটি তেইশ লাখ পঁয়তাল্লিশ হাজার ছয়শ আটাত্তর"

I18n.with_locale(:bn) { 2_000_000_000.to_words }
# => "দুইশ কোটি"

I18n.with_locale(:bn) { [1, 2, 3].to_words }
# => ["এক", "দুই", "তিন"]

I18n.with_locale(:bn) { [11, 22, 133].to_words }
# => ["এগারো", "বাইশ", "একশ তেত্রিশ"]
```

## Decimals

Decimals are read with দশমিক followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:bn) { 3.14.to_words }
# => "তিন দশমিক এক চার"

I18n.with_locale(:bn) { 21.05.to_words }
# => "একুশ দশমিক শূন্য পাঁচ"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:bn) { 0.1.to_words(precision: 2) }
# => "শূন্য দশমিক এক শূন্য"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:bn) { 21.77.to_words(micro_separator: "বিন্দু") }
# => "একুশ বিন্দু সাত সাত"
```

### Ordinal

`ordinal: true` gives the Sanskrit-derived ordinals প্রথম, দ্বিতীয়, তৃতীয়, চতুর্থ, পঞ্চম, ষষ্ঠ, সপ্তম, অষ্টম, নবম and দশম for 1 to 10, and adds তম to the cardinal above 10, as is common for larger numbers (একুশতম, একশতম). The formal Sanskrit-derived forms above 10, such as একাদশ and বিংশ, are not used. Ordinals do not change with gender. Decimals keep the cardinal form.

```ruby
I18n.with_locale(:bn) { 1.to_words(ordinal: true) }
# => "প্রথম"

I18n.with_locale(:bn) { 5.to_words(ordinal: true) }
# => "পঞ্চম"

I18n.with_locale(:bn) { 21.to_words(ordinal: true) }
# => "একুশতম"

I18n.with_locale(:bn) { 100.to_words(ordinal: true) }
# => "একশতম"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps দশমিক.

```ruby
I18n.with_locale(:bn) { 0.7.to_words(remove_zero: true) }
# => "দশমিক সাত"
```

## Sources

- [Wiktionary: Bengali Numerals](https://en.wiktionary.org/wiki/Appendix:Bengali_numerals): Cardinal and ordinal forms.
- [Omniglot: Bengali Numbers](https://www.omniglot.com/language/numbers/bengali.htm): Numeral spellings and the Indian grouping system.
- [Unicode CLDR: Bengali Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/bn.xml): The spell-out rules ICU uses to write numbers in words.
