# Russian (`ru`)

Русский. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:ru) { 0.to_words }
# => "ноль"

I18n.with_locale(:ru) { 21.to_words }
# => "двадцать один"

I18n.with_locale(:ru) { 231.to_words }
# => "двести тридцать один"

I18n.with_locale(:ru) { 4030.to_words }
# => "четыре тысячи тридцать"

I18n.with_locale(:ru) { 1_000_100.to_words }
# => "один миллион сто"

I18n.with_locale(:ru) { 2_000_000_000.to_words }
# => "два миллиарда"

I18n.with_locale(:ru) { [1, 2, 3].to_words }
# => ["один", "два", "три"]

I18n.with_locale(:ru) { [11, 22, 133].to_words }
# => ["одиннадцать", "двадцать два", "сто тридцать три"]
```

## Decimals

```ruby
I18n.with_locale(:ru) { 21.77.to_words }
# => "двадцать одна целая и семьдесят семь сотых"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:ru) { 0.1.to_words(precision: 2) }
# => "ноль целых и десять сотых"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ru) { 21.77.to_words(micro_separator: "plus") }
# => "двадцать одна целая plus семьдесят семь сотых"
```

### Gender

`gender: :male` (default), `:female` or `:neuter`.

```ruby
I18n.with_locale(:ru) { 1001.to_words(gender: :female) }
# => "одна тысяча одна"

I18n.with_locale(:ru) { 1001.to_words(gender: :neuter) }
# => "одна тысяча одно"
```

### Ordinal

`ordinal: true` makes the last word ordinal ("двадцать первый") and joins a round thousand or million to its multiplier ("двухтысячный"). A scale group of exactly one omits its one ("тысяча первый", "миллион первый"), while cardinals keep it ("одна тысяча один", "один миллион один"). Keeping один ("один миллион первый") is also correct. `gender:` selects the masculine, feminine or neuter ending.

```ruby
I18n.with_locale(:ru) { 1.to_words(ordinal: true) }
# => "первый"

I18n.with_locale(:ru) { 21.to_words(ordinal: true) }
# => "двадцать первый"

I18n.with_locale(:ru) { 2_000.to_words(ordinal: true) }
# => "двухтысячный"

I18n.with_locale(:ru) { 90_000.to_words(ordinal: true) }
# => "девяностотысячный"

I18n.with_locale(:ru) { 1001.to_words(ordinal: true) }
# => "тысяча первый"

I18n.with_locale(:ru) { 21.to_words(ordinal: true, gender: :female) }
# => "двадцать первая"

I18n.with_locale(:ru) { 1_000_001.to_words(ordinal: true) }
# => "миллион первый"
```

### Case

`case:` declines a number: `:nominative` (default), `:genitive`, `:dative`, `:accusative`, `:instrumental` or `:prepositional`. Every word of a cardinal declines. A scale word agrees with its numeral ("двадцати одной тысячи", "двух тысяч"). Only the last word of an ordinal declines ("двадцать первого"), in the ending `gender:` selects.

```ruby
I18n.with_locale(:ru) { 21.to_words(case: :genitive) }
# => "двадцати одного"

I18n.with_locale(:ru) { 21_000.to_words(case: :genitive) }
# => "двадцати одной тысячи"

I18n.with_locale(:ru) { 2_000.to_words(case: :dative) }
# => "двум тысячам"

I18n.with_locale(:ru) { 123_456.to_words(case: :instrumental) }
# => "ста двадцатью тремя тысячами четырьмястами пятьюдесятью шестью"

I18n.with_locale(:ru) { 1_000.to_words(case: :accusative) }
# => "одну тысячу"

I18n.with_locale(:ru) { 21.to_words(ordinal: true, case: :genitive) }
# => "двадцать первого"

I18n.with_locale(:ru) { 123.to_words(ordinal: true, case: :dative) }
# => "сто двадцать третьему"

I18n.with_locale(:ru) { 21.to_words(ordinal: true, gender: :female, case: :dative) }
# => "двадцать первой"

I18n.with_locale(:ru) { 3.to_words(ordinal: true, gender: :female, case: :accusative) }
# => "третью"

I18n.with_locale(:ru) { 2_000.to_words(ordinal: true, case: :prepositional) }
# => "двухтысячном"
```

Decimals are not declined: `case:` other than `:nominative` raises `NumbersAndWords::UnsupportedOptionError` for a decimal.

### Animate

`animate: true` gives the accusative its genitive form, as for an animate noun, instead of the default inanimate form. It applies to a masculine ordinal ("вижу двадцать первого"), "один" ("двадцать одного"), and "два", "три" and "четыре" alone ("двух"); compound numbers ending in them keep the nominative ("двадцать два").

```ruby
I18n.with_locale(:ru) { 21.to_words(ordinal: true, case: :accusative) }
# => "двадцать первый"

I18n.with_locale(:ru) { 21.to_words(ordinal: true, case: :accusative, animate: true) }
# => "двадцать первого"

I18n.with_locale(:ru) { 2.to_words(case: :accusative, animate: true) }
# => "двух"

I18n.with_locale(:ru) { 22.to_words(case: :accusative, animate: true) }
# => "двадцать два"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:ru) { 0.7.to_words(remove_zero: true) }
# => "семь десятых"
```

## Sources

- [Gramota: Numerals](https://gramota.ru/biblioteka/spravochniki/imya-chislitelnoe): Cardinal and ordinal grammar and declension.
- [Rosenthal: Compounds Without a Connecting Vowel](https://rus-yaz.niv.ru/doc/rules-rosental/articles/042-slozhnye-slova-bez-soedinitelnoj.htm): Combining stems, including девяносто.
- [Wiktionary: девяностотысячный](https://ru.wiktionary.org/wiki/девяностотысячный): The ninety-thousandth ordinal.
- [NumeralOnline: 1,000,001](https://numeralonline.ru/1000001): A compound ordinal variant retaining один before миллион.
- [Unicode CLDR: Russian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/ru.xml): The spell-out rules ICU uses to write numbers in words.
