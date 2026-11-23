# Hebrew (`he`)

עברית is the Hebrew name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers use the feminine counting form by default (אחת, שתיים, שלוש); see [Gender](#gender). Multipliers of אלף, מיליון and larger are masculine (עשרים ואחד אלף). 2,000 to 10,000 have their own forms (אלפיים, שלושת אלפים, עשרת אלפים). The conjunction ו joins the last part of each group (עשרים ואחת), and joins a single last part to the rest of the number (אלף ואחת). Scale words follow the short scale used in Israel, with מיליארד for 10<sup>9</sup> and טריליון for 10<sup>12</sup>, up to דסיליון (10<sup>33</sup>). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Hebrew is written right to left. The `to_words` method returns the words in logical (reading) order without bidirectional control characters. They display correctly wherever right-to-left text is supported, such as an HTML element with `dir="rtl"` or `dir="auto"`. Inside left-to-right text, isolate them, for example with `<bdi>` in HTML. A terminal without bidirectional support shows the letters reversed.

## Examples

```ruby
I18n.with_locale(:he) { 0.to_words }
# => "אפס"

I18n.with_locale(:he) { 21.to_words }
# => "עשרים ואחת"

I18n.with_locale(:he) { 231.to_words }
# => "מאתיים שלושים ואחת"

I18n.with_locale(:he) { 4030.to_words }
# => "ארבעת אלפים ושלושים"

I18n.with_locale(:he) { 123_456.to_words }
# => "מאה עשרים ושלושה אלף ארבע מאות חמישים ושש"

I18n.with_locale(:he) { 1_000_100.to_words }
# => "מיליון ומאה"

I18n.with_locale(:he) { 2_000_000_000.to_words }
# => "שני מיליארד"

I18n.with_locale(:he) { [1, 2, 3].to_words }
# => ["אחת", "שתיים", "שלוש"]

I18n.with_locale(:he) { [11, 22, 133].to_words }
# => ["אחת עשרה", "עשרים ושתיים", "מאה שלושים ושלוש"]
```

## Decimals

Decimals are read with נקודה followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:he) { 3.14.to_words }
# => "שלוש נקודה אחת ארבע"

I18n.with_locale(:he) { 21.05.to_words }
# => "עשרים ואחת נקודה אפס חמש"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:he) { 0.1.to_words(precision: 2) }
# => "אפס נקודה אחת אפס"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:he) { 21.77.to_words(micro_separator: "פסיק") }
# => "עשרים ואחת פסיק שבע שבע"
```

### Gender

With `gender: :female` (the default) or `gender: :male`, the number takes the gender of what is counted. It applies to the last group of digits. Multipliers of thousands and larger are always masculine.

```ruby
I18n.with_locale(:he) { 21.to_words(gender: :male) }
# => "עשרים ואחד"

I18n.with_locale(:he) { 12.to_words(gender: :male) }
# => "שנים עשר"

I18n.with_locale(:he) { 2.to_words(gender: :female) }
# => "שתיים"
```

### Ordinal

With `ordinal: true`, 1 to 10 take their ordinal words in the requested gender. Above 10, Hebrew uses the definite cardinal (`היום העשרים ואחד`). After a one-word multiplier, the article goes on the noun it counts (שלוש המאות, שלושת האלפים, שני המיליון). 0 raises `RangeError`.

```ruby
I18n.with_locale(:he) { 1.to_words(ordinal: true) }
# => "ראשונה"

I18n.with_locale(:he) { 1.to_words(ordinal: true, gender: :male) }
# => "ראשון"

I18n.with_locale(:he) { 21.to_words(ordinal: true, gender: :male) }
# => "העשרים ואחד"

I18n.with_locale(:he) { 3000.to_words(ordinal: true) }
# => "שלושת האלפים"
```

### Remove Zero

With `remove_zero: true`, a zero integral part is omitted.

```ruby
I18n.with_locale(:he) { 0.7.to_words(remove_zero: true) }
# => "נקודה שבע"
```

## Units

With the [`unit`](../../README.md#unit) option, one follows its unit (שקל אחד, אגורה אחת). Two takes its construct form before the unit (שני שקלים, שתי אגורות), and other numbers also come first (שלושה שקלים, עשרים ואחד שקלים). A unit's `gender` sets the gender of the number. A subunit is joined with ו prefixed to its first word. Combining `unit` with `ordinal: true` raises `NumbersAndWords::UnsupportedOptionError`, because a Hebrew ordinal follows its noun with an article.

```ruby
I18n.with_locale(:he) { 1.to_words(unit: :shekel) }
# => "שקל אחד"

I18n.with_locale(:he) { 2.to_words(unit: :shekel) }
# => "שני שקלים"

I18n.with_locale(:he) { 21.to_words(unit: :shekel) }
# => "עשרים ואחד שקלים"

I18n.with_locale(:he) { 12.02.to_words(unit: :shekel, subunit: :agora) }
# => "שנים עשר שקלים ושתי אגורות"
```

## Sources

- [Academy of the Hebrew Language: Use of Numerals](https://hebrew-academy.org.il/topic/hahlatot/grammardecisions/terminology-ordinance/4-3-%D7%94%D7%A9%D7%99%D7%9E%D7%95%D7%A9-%D7%91%D7%A9%D7%9D-%D7%94%D7%9E%D7%A1%D7%A4%D7%A8/): Gender, construct forms and definiteness in numeral phrases.
- [Academy of the Hebrew Language: טריליון](https://terms.hebrew-academy.org.il/munnah/48993_2): The Academy's general terms (2013) give טריליון for 10<sup>12</sup>; its 1985 mathematics dictionary had ביליון, which Unicode CLDR still uses.
- [Hebrew Wikipedia: Number Names](https://he.wikipedia.org/wiki/שמות_מספרים): Israel uses the short scale with מיליארד for 10<sup>9</sup>, and the spellings of the larger scale words.
- [Unicode CLDR: Hebrew Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/he.xml): The spell-out rules ICU uses to write numbers in words.
