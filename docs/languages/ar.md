# Arabic (`ar`)

العربية. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are returned in logical (reading) order, and the application's display lays them out right to left; the gem adds no bidirectional control characters.

Numbers use the masculine counting form. Groups of three digits are read from the largest, every part is joined with و ("and"), and ones come before tens (21 is واحد وعشرون). A scale word takes the form its count requires: singular for 1 (ألف), dual for 2 (ألفان), plural for 3 to 10 (ثلاثة آلاف) and accusative singular for 11 to 99 (أحد عشر ألفًا). After round hundreds it is singular (مائة ألف), and 200 takes its construct form (مائتا ألف). Hundreds are spelled مائة. Numbers up to 10^21 - 1 are supported.

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

Decimals are not supported yet.

## Options

### Precision

`precision` pads the fractional part of a decimal, so it has no effect until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal, so it has no effect until decimals are supported.

### Ordinal

`ordinal: true` gives the masculine definite ordinal from 1 to 99. One is `الحادي` in compounds. Other numbers raise `RangeError`, and the feminine forms are not supported yet.

```ruby
I18n.with_locale(:ar) { 1.to_words(ordinal: true) }
# => "الأول"

I18n.with_locale(:ar) { 11.to_words(ordinal: true) }
# => "الحادي عشر"

I18n.with_locale(:ar) { 21.to_words(ordinal: true) }
# => "الحادي والعشرون"
```
