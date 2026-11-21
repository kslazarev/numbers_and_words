# Korean (`ko`)

한국어. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are Sino-Korean numbers written in Hangul. Digits are grouped by ten thousands: each group of up to four digits uses the places 십 (10), 백 (100) and 천 (1,000), and is followed by 만 (10^4), 억 (10^8), 조 (10^12), 경 (10^16), 해 (10^20) and so on up to 극 (10^48); larger numbers raise `RangeError`. 일 is not read before 십, 백 and 천 (십일, 백, 천), nor before 만 (만, 만 일, 일억 만), but is before larger scales (일억, 일조). Skipped places are not read (백일). Following the Korean spelling rules (한글 맞춤법 제44항), groups are separated by a space in units of 만 (만 이천삼백사십오), and the words within a group are written together. Zero is 영; the 공 used when reading digits such as phone numbers is not supported. Native Korean numbers (하나, 둘, 셋) and counters are not supported yet.

## Examples

```ruby
I18n.with_locale(:ko) { 0.to_words }
# => "영"

I18n.with_locale(:ko) { 21.to_words }
# => "이십일"

I18n.with_locale(:ko) { 110.to_words }
# => "백십"

I18n.with_locale(:ko) { 4030.to_words }
# => "사천삼십"

I18n.with_locale(:ko) { 10_000.to_words }
# => "만"

I18n.with_locale(:ko) { 12_345.to_words }
# => "만 이천삼백사십오"

I18n.with_locale(:ko) { 100_000_000.to_words }
# => "일억"

I18n.with_locale(:ko) { 123_456_789.to_words }
# => "일억 이천삼백사십오만 육천칠백팔십구"

I18n.with_locale(:ko) { 1_000_000_000_000.to_words }
# => "일조"

I18n.with_locale(:ko) { [1, 2, 3].to_words }
# => ["일", "이", "삼"]

I18n.with_locale(:ko) { [11, 22, 133].to_words }
# => ["십일", "이십이", "백삼십삼"]
```

## Decimals

Decimals are read with 점 followed by each fractional digit, including leading zeros, with a space on each side of 점.

```ruby
I18n.with_locale(:ko) { 3.14.to_words }
# => "삼 점 일사"

I18n.with_locale(:ko) { 21.05.to_words }
# => "이십일 점 영오"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:ko) { 0.1.to_words(precision: 2) }
# => "영 점 일영"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ko) { 21.77.to_words(micro_separator: "plus") }
# => "이십일 plus 칠칠"
```

### Ordinal

`ordinal: true` adds the formal prefix 제 to integers. The native ordinals (첫째, 둘째) and the counter 번째 are not supported yet.

```ruby
I18n.with_locale(:ko) { 1.to_words(ordinal: true) }
# => "제일"

I18n.with_locale(:ko) { 21.to_words(ordinal: true) }
# => "제이십일"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps 점.

```ruby
I18n.with_locale(:ko) { 0.7.to_words(remove_zero: true) }
# => "점 칠"
```

## Sources

- [How to Study Korean: Numbers](https://www.howtostudykorean.com/unit1/unit-1-lessons-9-16/unit-1-lesson-10/): Sino-Korean and native Korean cardinal systems.
- [Unicode CLDR: Korean Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/ko.xml): The spell-out rules ICU uses to write numbers in words.
