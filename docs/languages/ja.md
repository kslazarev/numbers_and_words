# Japanese (`ja`)

日本語. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are written in kanji numerals without spaces. Digits are grouped by ten thousands: each group of up to four digits uses the places 十 (10), 百 (100) and 千 (1,000), and is followed by 万 (10^4), 億 (10^8), 兆 (10^12), 京 (10^16), 垓 (10^20) and so on up to 極 (10^48); larger numbers raise `RangeError`. 一 is not written before 十, 百 and 千 (十一, 百, 千, 一万千) but is before every scale (一万, 一億), and skipped places are not read (百一, 一万一). Zero is 零, which is also used for zero digits after the decimal point; the positional 〇 used to write digits one by one (二〇二四) is not supported. 一千 within larger numbers (一千万, 一万一千) is not supported yet, and native numbers (ひとつ, ふたつ) and counters are not supported.

## Examples

```ruby
I18n.with_locale(:ja) { 0.to_words }
# => "零"

I18n.with_locale(:ja) { 21.to_words }
# => "二十一"

I18n.with_locale(:ja) { 110.to_words }
# => "百十"

I18n.with_locale(:ja) { 4030.to_words }
# => "四千三十"

I18n.with_locale(:ja) { 12_345.to_words }
# => "一万二千三百四十五"

I18n.with_locale(:ja) { 1_000_100.to_words }
# => "百万百"

I18n.with_locale(:ja) { 123_456_789.to_words }
# => "一億二千三百四十五万六千七百八十九"

I18n.with_locale(:ja) { 1_000_000_000_000.to_words }
# => "一兆"

I18n.with_locale(:ja) { [1, 2, 3].to_words }
# => ["一", "二", "三"]

I18n.with_locale(:ja) { [11, 22, 133].to_words }
# => ["十一", "二十二", "百三十三"]
```

## Decimals

Decimals are read with 点 followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:ja) { 3.14.to_words }
# => "三点一四"

I18n.with_locale(:ja) { 21.05.to_words }
# => "二十一点零五"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:ja) { 0.1.to_words(precision: 2) }
# => "零点一零"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ja) { 21.77.to_words(micro_separator: "plus") }
# => "二十一plus七七"
```

### Ordinal

`ordinal: true` adds the prefix 第 (だい) to integers.

```ruby
I18n.with_locale(:ja) { 21.to_words(ordinal: true) }
# => "第二十一"

I18n.with_locale(:ja) { 21.to_words(ordinal: true, script: :kana) }
# => "だいにじゅういち"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps 点.

```ruby
I18n.with_locale(:ja) { 0.7.to_words(remove_zero: true) }
# => "点七"
```

### Script

`script: :kanji` (the default) writes kanji numerals; `script: :kana` writes their reading in hiragana. Readings use よん for 4, なな for 7, きゅう for 9 and れい for 0, and the usual sound changes: 300 is さんびゃく, 600 ろっぴゃく, 800 はっぴゃく, 3,000 さんぜん and 8,000 はっせん, and いち, はち and じゅう become いっ, はっ and じゅっ before 兆 (ちょう), 京 (けい) and 点 (てん), as do ろく and ひゃく before 京 (いっちょう, じゅっちょう, ろっけい, ひゃっけい, いってんご). 十 before these words is read じゅっ rather than the older じっ.

```ruby
I18n.with_locale(:ja) { 300.to_words(script: :kana) }
# => "さんびゃく"

I18n.with_locale(:ja) { 8000.to_words(script: :kana) }
# => "はっせん"

I18n.with_locale(:ja) { 12_345.to_words(script: :kana) }
# => "いちまんにせんさんびゃくよんじゅうご"

I18n.with_locale(:ja) { 1_000_000_000_000.to_words(script: :kana) }
# => "いっちょう"

I18n.with_locale(:ja) { 1.5.to_words(script: :kana) }
# => "いってんご"
```

## Sources

- [Japanese Numeral Scale Table](https://greater-good.xyz/study/math/doc/digitJp-big): Large-number names and grouping.
- [Kanshudo: Pronouncing the Decimal Point](https://www.kanshudo.com/poi/pronouncing_decimal_point): Decimal readings.
- [Wiktionary: 京 Numeral Table](https://en.wiktionary.org/wiki/Template:ja-number-number:%E4%BA%AC): The reading of the 10¹⁶ scale word.
- [Unicode CLDR: Japanese Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/ja.xml): The spell-out rules ICU uses to write numbers in words.
