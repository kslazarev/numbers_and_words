# Burmese (`my`)

မြန်မာဘာသာ. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are written without spaces.

The places are ဆယ် (10), ရာ (100), ထောင် (1,000), သောင်း (10,000), သိန်း (100,000), သန်း (1,000,000) and ကုဋေ (10<sup>7</sup>). Ten is ဆယ် without တစ်. ဆယ်, ရာ and ထောင် take the creaky tone (ဆယ့်, ရာ့, ထောင့်) when another number follows them (နှစ်ဆယ့်တစ်, သုံးရာ့တစ်, တစ်ထောင့်တစ်ရာ), but not at the end of the number (နှစ်ဆယ်). ကုဋေ counts up to ten million of itself (10<sup>9</sup> is တစ်ရာကုဋေ, 10<sup>12</sup> is တစ်သိန်းကုဋေ). ကောဋိ (10<sup>14</sup>) counts any number of itself, so there is no largest number. Burmese numbers have no gender.

Seven is spelled ခုနစ်, as in the Myanmar Language Commission dictionary; the Unicode CLDR rules write ခုနှစ်. CLDR keeps the low tone of ten after 20 (နှစ်ဆယ်တစ်), but the gem uses the creaky tone there too. From 10<sup>18</sup> on, past the CLDR rules, the readings continue CLDR's ကောဋိ (10<sup>21</sup> is တစ်ကုဋေကောဋိ) and need a native speaker's review.

## Examples

```ruby
I18n.with_locale(:my) { 0.to_words }
# => "သုည"

I18n.with_locale(:my) { 21.to_words }
# => "နှစ်ဆယ့်တစ်"

I18n.with_locale(:my) { 301.to_words }
# => "သုံးရာ့တစ်"

I18n.with_locale(:my) { 123_456.to_words }
# => "တစ်သိန်းနှစ်သောင်းသုံးထောင့်လေးရာ့ငါးဆယ့်ခြောက်"

I18n.with_locale(:my) { 21_000_000.to_words }
# => "နှစ်ကုဋေတစ်သန်း"

I18n.with_locale(:my) { 1_000_000_000.to_words }
# => "တစ်ရာကုဋေ"

I18n.with_locale(:my) { 100_000_000_000_000.to_words }
# => "တစ်ကောဋိ"

I18n.with_locale(:my) { -5.to_words }
# => "အနုတ်ငါး"

I18n.with_locale(:my) { [11, 22, 133].to_words }
# => ["ဆယ့်တစ်", "နှစ်ဆယ့်နှစ်", "တစ်ရာ့သုံးဆယ့်သုံး"]
```

## Decimals

Decimals are read with ဒသမ followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:my) { 10.1.to_words }
# => "ဆယ်ဒသမတစ်"

I18n.with_locale(:my) { 21.05.to_words }
# => "နှစ်ဆယ့်တစ်ဒသမသုညငါး"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:my) { 0.1.to_words(precision: 2) }
# => "သုညဒသမတစ်သုည"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:my) { 21.77.to_words(micro_separator: "plus") }
# => "နှစ်ဆယ့်တစ်plusခုနစ်ခုနစ်"
```

### Ordinal

`ordinal: true` gives the Pali ordinals from first to tenth (ပထမ to ဒသမ). Larger ordinals, and zero, are the cardinal, as in the Unicode CLDR rules. In a sentence Burmese adds a measure word and မြောက် (ဆယ့်တစ်ခုမြောက်). The measure word depends on the noun, so the gem leaves it to the caller.

```ruby
I18n.with_locale(:my) { 1.to_words(ordinal: true) }
# => "ပထမ"

I18n.with_locale(:my) { 10.to_words(ordinal: true) }
# => "ဒသမ"

I18n.with_locale(:my) { 21.to_words(ordinal: true) }
# => "နှစ်ဆယ့်တစ်"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:my) { 0.7.to_words(remove_zero: true) }
# => "ဒသမခုနစ်"
```

## Sources

- [Wikipedia: Burmese Numerals](https://en.wikipedia.org/wiki/Burmese_numerals): Numerals, the spelling ခုနစ်, the creaky tone before a following number, large numbers, Pali ordinals and decimals with ဒသမ.
- [Unicode CLDR: Burmese Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/my.xml): The spell-out rules ICU uses to write numbers in words, with ကုဋေ and ကောဋိ.
