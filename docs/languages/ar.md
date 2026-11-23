# Arabic (`ar`)

العربية. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are returned in logical (reading) order without bidirectional control characters; the application's display lays them out right to left.

Numbers use the masculine counting form. Groups of three digits are read from the largest, every part is joined with و ("and"), and ones come before tens (21 is واحد وعشرون). A scale word takes the form its count requires: singular for 1 (ألف), dual for 2 (ألفان), plural for 3 to 10 (ثلاثة آلاف) and accusative singular for 11 to 99 (أحد عشر ألفًا). After round hundreds it is singular (مائة ألف), and 200 takes its construct form (مائتا ألف). Hundreds are spelled مائة. Scale words follow the short scale up to ديسيليون (10<sup>33</sup>), and numbers up to 10<sup>36</sup> - 1 are supported.

## Examples

```ruby
I18n.with_locale(:ar) { 0.to_words }
# => "صفر"

I18n.with_locale(:ar) { 21.to_words }
# => "واحد وعشرون"

I18n.with_locale(:ar) { 231.to_words }
# => "مائتان وواحد وثلاثون"

I18n.with_locale(:ar) { 1234.to_words }
# => "ألف ومائتان وأربعة وثلاثون"

I18n.with_locale(:ar) { 3000.to_words }
# => "ثلاثة آلاف"

I18n.with_locale(:ar) { 11_000.to_words }
# => "أحد عشر ألفًا"

I18n.with_locale(:ar) { 200_000.to_words }
# => "مائتا ألف"

I18n.with_locale(:ar) { 1_000_100.to_words }
# => "مليون ومائة"

I18n.with_locale(:ar) { 2_000_000_000.to_words }
# => "ملياران"

I18n.with_locale(:ar) { [1, 2, 3].to_words }
# => ["واحد", "اثنان", "ثلاثة"]

I18n.with_locale(:ar) { [11, 22, 133].to_words }
# => ["أحد عشر", "اثنان وعشرون", "مائة وثلاثة وثلاثون"]
```

## Decimals

Decimals are read with فاصل and then each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:ar) { 3.14.to_words }
# => "ثلاثة فاصل واحد أربعة"

I18n.with_locale(:ar) { 21.05.to_words }
# => "واحد وعشرون فاصل صفر خمسة"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:ar) { 0.1.to_words(precision: 2) }
# => "صفر فاصل واحد صفر"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ar) { 21.77.to_words(micro_separator: "نقطة") }
# => "واحد وعشرون نقطة سبعة سبعة"
```

### Unit

With the [`unit`](../../README.md#unit) option, a unit takes the form the Arabic plural rule picks for its count: `one` for 1, with the number after the unit (دينار واحد); `two` for 2, the dual alone (ديناران); `few` for counts ending in 03 to 10, the plural (ثلاثة دنانير); `many` for counts ending in 11 to 99, the accusative singular (أحد عشر دينارًا); `zero` for 0; and `other` for the rest, the genitive singular (مائة دينار). Before the unit a dual scale word or hundred takes its construct form (ألفا دينار, مائتا دينار), and an accusative one drops its ending (أحد عشر ألف دينار). A subunit is joined with و attached to it.

A count above 100 ending in 01 or 02, such as 101, repeats the unit (مائة دينار ودينار) and raises `NumbersAndWords::UnsupportedNumberError`. Numbers are masculine only, so a unit with `gender: female`, and `unit` with `ordinal: true`, raise `NumbersAndWords::UnsupportedOptionError`.

For a Kuwaiti dinar, which has 1,000 fils, pass `precision: 3`.

```ruby
I18n.with_locale(:ar) { 1.to_words(unit: :dinar) }
# => "دينار واحد"

I18n.with_locale(:ar) { 2.to_words(unit: :dinar) }
# => "ديناران"

I18n.with_locale(:ar) { 3.to_words(unit: :dinar) }
# => "ثلاثة دنانير"

I18n.with_locale(:ar) { 11.to_words(unit: :dinar) }
# => "أحد عشر دينارًا"

I18n.with_locale(:ar) { 2_000.to_words(unit: :dinar) }
# => "ألفا دينار"

I18n.with_locale(:ar) { 1.5.to_words(unit: :dinar, subunit: :fils, precision: 3) }
# => "دينار واحد وخمسمائة فلس"
```

### Ordinal

`ordinal: true` gives the masculine definite ordinal from 1 to 99. One is `الحادي` in compounds. Other numbers raise `RangeError`; feminine forms are not supported yet.

```ruby
I18n.with_locale(:ar) { 1.to_words(ordinal: true) }
# => "الأول"

I18n.with_locale(:ar) { 11.to_words(ordinal: true) }
# => "الحادي عشر"

I18n.with_locale(:ar) { 21.to_words(ordinal: true) }
# => "الحادي والعشرون"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps فاصل.

```ruby
I18n.with_locale(:ar) { 0.7.to_words(remove_zero: true) }
# => "فاصل سبعة"
```

## Sources

- [Numbers in Arabic](https://numbersinarabic.com/big-numbers/): Hundreds and larger cardinal numbers.
- [Kuwaiti Dinar](https://en.wikipedia.org/wiki/Kuwaiti_dinar): The 1,000-fils subdivision used in the currency example.
- [Arabic Wikipedia: List of Numbers](https://ar.wikipedia.org/wiki/قائمة_الأعداد): The short-scale names تريليون, كوادريليون, كوينتليون and سكستليون.
- [Unicode CLDR: Arabic Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/ar.xml): The spell-out rules ICU uses to write numbers in words.
