# Hebrew (`he`)

עברית. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers use the feminine counting form by default (אחת, שתיים, שלוש); see [Gender](#gender). Multipliers of אלף, מיליון and larger are masculine (עשרים ואחד אלף), and 2,000 to 10,000 have their own forms (אלפיים, שלושת אלפים, עשרת אלפים). The conjunction ו joins the last part of each group (עשרים ואחת), and a single last part to the rest of the number (אלף ואחת). Numbers up to 999,999,999,999,999 are supported; larger numbers raise `RangeError`.

Hebrew is written right to left. `to_words` returns the words in logical order, the order they are read, and adds no bidirectional control characters, so the text displays correctly wherever right-to-left text is supported, such as an HTML element with `dir="rtl"` or `dir="auto"`. Where the words are embedded in left-to-right text, isolate them, for example with `<bdi>` in HTML. A terminal without bidirectional support shows the letters reversed.

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

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:he) { 0.1.to_words(precision: 2) }
# => "אפס נקודה אחת אפס"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:he) { 21.77.to_words(micro_separator: "פסיק") }
# => "עשרים ואחת פסיק שבע שבע"
```

### Gender

`gender: :female` (the default) or `gender: :male`, the gender of what is counted. It applies to the last group of digits; multipliers of thousands and larger are always masculine.

```ruby
I18n.with_locale(:he) { 21.to_words(gender: :male) }
# => "עשרים ואחד"

I18n.with_locale(:he) { 12.to_words(gender: :male) }
# => "שנים עשר"

I18n.with_locale(:he) { 2.to_words(gender: :female) }
# => "שתיים"
```

### Ordinal

`ordinal: true` gives the ordinal words for 1 to 10, in the requested gender, and the definite cardinal above 10, as Hebrew does (`היום העשרים ואחד`). 0 raises `RangeError`.

```ruby
I18n.with_locale(:he) { 1.to_words(ordinal: true) }
# => "ראשונה"

I18n.with_locale(:he) { 1.to_words(ordinal: true, gender: :male) }
# => "ראשון"

I18n.with_locale(:he) { 21.to_words(ordinal: true, gender: :male) }
# => "העשרים ואחד"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:he) { 0.7.to_words(remove_zero: true) }
# => "נקודה שבע"
```
