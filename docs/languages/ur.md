# Urdu (`ur`)

اردو. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are in Urdu letters (ک, ہ, ی and ے, not the Arabic ك, ه and ي), separated by spaces.

Urdu uses the Indian numbering system. Each number from 0 to 99 is its own word (اکیس, اٹھہتر, ننانوے), not a compound of tens and ones. The last three digits are read as hundreds (چھ سو اٹھہتر), and each scale above them counts from 1 to 99: ہزار (10^3), لاکھ (10^5), کروڑ (10^7), ارب (10^9) and کھرب (10^11), so 1,23,45,678 is ایک کروڑ تئیس لاکھ پینتالیس ہزار چھ سو اٹھہتر. Larger numbers repeat کھرب with its count spelled the same way (10^13 is ایک سو کھرب). 100 and 1,000 are ایک سو and ایک ہزار.

Urdu is written right to left. `to_words` returns the words in logical (reading) order without bidirectional control characters, so they display correctly wherever right-to-left text is supported, such as an HTML element with `dir="rtl"` or `dir="auto"`. Inside left-to-right text, isolate them, for example with `<bdi>` in HTML. A terminal without bidirectional support shows the letters reversed.

## Examples

```ruby
I18n.with_locale(:ur) { 0.to_words }
# => "صفر"

I18n.with_locale(:ur) { 21.to_words }
# => "اکیس"

I18n.with_locale(:ur) { 78.to_words }
# => "اٹھہتر"

I18n.with_locale(:ur) { 231.to_words }
# => "دو سو اکتیس"

I18n.with_locale(:ur) { 4030.to_words }
# => "چار ہزار تیس"

I18n.with_locale(:ur) { 123_456.to_words }
# => "ایک لاکھ تئیس ہزار چار سو چھپن"

I18n.with_locale(:ur) { 12_345_678.to_words }
# => "ایک کروڑ تئیس لاکھ پینتالیس ہزار چھ سو اٹھہتر"

I18n.with_locale(:ur) { 2_000_000_000.to_words }
# => "دو ارب"

I18n.with_locale(:ur) { [1, 2, 3].to_words }
# => ["ایک", "دو", "تین"]

I18n.with_locale(:ur) { [11, 22, 133].to_words }
# => ["گیارہ", "بائیس", "ایک سو تینتیس"]
```

## Decimals

Decimals are read with اعشاریہ followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:ur) { 3.14.to_words }
# => "تین اعشاریہ ایک چار"

I18n.with_locale(:ur) { 21.05.to_words }
# => "اکیس اعشاریہ صفر پانچ"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:ur) { 0.1.to_words(precision: 2) }
# => "صفر اعشاریہ ایک صفر"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ur) { 21.77.to_words(micro_separator: "نقطہ") }
# => "اکیس نقطہ سات سات"
```

### Ordinal

`ordinal: true` gives پہلا, دوسرا, تیسرا, چوتھا, چھٹا and نواں for 1, 2, 3, 4, 6 and 9, and adds واں to the cardinal otherwise (پانچواں, اکیسواں, ایک سوواں). Larger numbers ending in these add واں (101 is ایک سو ایکواں). Decimals keep the cardinal form.

```ruby
I18n.with_locale(:ur) { 1.to_words(ordinal: true) }
# => "پہلا"

I18n.with_locale(:ur) { 5.to_words(ordinal: true) }
# => "پانچواں"

I18n.with_locale(:ur) { 21.to_words(ordinal: true) }
# => "اکیسواں"

I18n.with_locale(:ur) { 100.to_words(ordinal: true) }
# => "ایک سوواں"
```

### Gender

`gender: :male` (the default) or `gender: :female`, the gender of an ordinal: پہلی, دوسری, چھٹی, نویں, and ویں instead of واں. Cardinals do not change.

```ruby
I18n.with_locale(:ur) { 1.to_words(ordinal: true, gender: :female) }
# => "پہلی"

I18n.with_locale(:ur) { 5.to_words(ordinal: true, gender: :female) }
# => "پانچویں"

I18n.with_locale(:ur) { 2.to_words(ordinal: true, gender: :male) }
# => "دوسرا"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps اعشاریہ.

```ruby
I18n.with_locale(:ur) { 0.7.to_words(remove_zero: true) }
# => "اعشاریہ سات"
```

## Sources

- [Urdu-English: Numbers](https://www.urdu-english.com/lessons/beginner/numbers): Basic cardinal spellings and readings.
- [Wikiversity: Urdu Numbers](https://en.wikiversity.org/wiki/Urdu_Numbers): Numeral tables.
- [Unicode CLDR: Urdu Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/ur.xml): The spell-out rules ICU uses to write numbers in words.
