# Chinese (`zh`)

中文 (简体). This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are written in Simplified Chinese characters without spaces. Digits are grouped by ten thousands: each group of up to four digits uses the places 十 (10), 百 (100) and 千 (1,000), and is followed by 万 (10^4), 亿 (10^8), 万亿 (10^12), 亿亿 (10^16) and so on. A single 零 marks skipped places between nonzero digits (101 is 一百零一, 1,000,100 is 一百万零一百), and a number from 10 to 19 at the start drops its leading 一 (15 is 十五, 110,000 is 十一万). The formal 二 is used for 2 everywhere; the colloquial 两 is not supported yet. Regional locales such as `zh-CN` use `zh`; Traditional Chinese (`zh-TW`, `zh-HK`) characters are not supported yet.

## Examples

```ruby
I18n.with_locale(:zh) { 0.to_words }
# => "零"

I18n.with_locale(:zh) { 21.to_words }
# => "二十一"

I18n.with_locale(:zh) { 231.to_words }
# => "二百三十一"

I18n.with_locale(:zh) { 4030.to_words }
# => "四千零三十"

I18n.with_locale(:zh) { 123_456.to_words }
# => "十二万三千四百五十六"

I18n.with_locale(:zh) { 1_000_100.to_words }
# => "一百万零一百"

I18n.with_locale(:zh) { 2_000_000_000.to_words }
# => "二十亿"

I18n.with_locale(:zh) { [1, 2, 3].to_words }
# => ["一", "二", "三"]

I18n.with_locale(:zh) { [11, 22, 133].to_words }
# => ["十一", "二十二", "一百三十三"]
```

## Decimals

Decimals are read with 点 followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:zh) { 3.14.to_words }
# => "三点一四"

I18n.with_locale(:zh) { 21.05.to_words }
# => "二十一点零五"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:zh) { 0.1.to_words(precision: 2) }
# => "零点一零"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:zh) { 21.77.to_words(micro_separator: "plus") }
# => "二十一plus七七"
```

### Ordinal

`ordinal: true` adds the prefix 第 to integers.

```ruby
I18n.with_locale(:zh) { 1.to_words(ordinal: true) }
# => "第一"

I18n.with_locale(:zh) { 21.to_words(ordinal: true) }
# => "第二十一"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps 点.

```ruby
I18n.with_locale(:zh) { 0.7.to_words(remove_zero: true) }
# => "点七"
```
