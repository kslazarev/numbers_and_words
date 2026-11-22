# Thai (`th`)

ภาษาไทย. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are written without spaces. Each group of up to six digits uses the places สิบ (10), ร้อย (100), พัน (1,000), หมื่น (10,000) and แสน (100,000), and ล้าน (1,000,000) repeats for larger numbers, so 10^12 is หนึ่งล้านล้าน. A final 1 is read เอ็ด in a number with at least two digits, including across million groups (1,000,001 is หนึ่งล้านเอ็ด); 1 alone and a fractional 1 stay หนึ่ง.

## Examples

```ruby
I18n.with_locale(:th) { 0.to_words }
# => "ศูนย์"

I18n.with_locale(:th) { 21.to_words }
# => "ยี่สิบเอ็ด"

I18n.with_locale(:th) { 231.to_words }
# => "สองร้อยสามสิบเอ็ด"

I18n.with_locale(:th) { 4030.to_words }
# => "สี่พันสามสิบ"

I18n.with_locale(:th) { 123_456.to_words }
# => "หนึ่งแสนสองหมื่นสามพันสี่ร้อยห้าสิบหก"

I18n.with_locale(:th) { 1_000_100.to_words }
# => "หนึ่งล้านหนึ่งร้อย"

I18n.with_locale(:th) { 1_000_001.to_words }
# => "หนึ่งล้านเอ็ด"

I18n.with_locale(:th) { 2_000_000_000.to_words }
# => "สองพันล้าน"

I18n.with_locale(:th) { [1, 2, 3].to_words }
# => ["หนึ่ง", "สอง", "สาม"]

I18n.with_locale(:th) { [11, 22, 133].to_words }
# => ["สิบเอ็ด", "ยี่สิบสอง", "หนึ่งร้อยสามสิบสาม"]
```

## Decimals

Decimals are read with จุด followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:th) { 3.14.to_words }
# => "สามจุดหนึ่งสี่"

I18n.with_locale(:th) { 21.05.to_words }
# => "ยี่สิบเอ็ดจุดศูนย์ห้า"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:th) { 0.1.to_words(precision: 2) }
# => "ศูนย์จุดหนึ่งศูนย์"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:th) { 21.77.to_words(micro_separator: "plus") }
# => "ยี่สิบเอ็ดplusเจ็ดเจ็ด"
```

### Ordinal

`ordinal: true` adds the prefix ที่ to integers.

```ruby
I18n.with_locale(:th) { 1.to_words(ordinal: true) }
# => "ที่หนึ่ง"

I18n.with_locale(:th) { 21.to_words(ordinal: true) }
# => "ที่ยี่สิบเอ็ด"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:th) { 0.7.to_words(remove_zero: true) }
# => "จุดเจ็ด"
```

## Sources

- [Royal Society: Final One](http://legacy.orst.go.th/?knowledges=%E0%B8%AB%E0%B8%99%E0%B8%B6%E0%B9%88%E0%B8%87-%E0%B8%AB%E0%B8%A3%E0%B8%B7%E0%B8%AD-%E0%B9%80%E0%B8%AD%E0%B9%87%E0%B8%94-%E0%B9%95-%E0%B8%81%E0%B8%A3%E0%B8%81%E0%B8%8E%E0%B8%B2%E0%B8%84%E0%B8%A1): Use of เอ็ด at the end of numbers with at least two digits.
- [Baht Text Examples](https://koishiai.com/en/tools/baht-text): Readings across million boundaries.
- [Microsoft: BAHTTEXT Function](https://support.microsoft.com/en-us/office/bahttext-function-5ba4d0b4-abd3-4325-8d22-7a92d59aab9c): Excel's Thai amounts in words, which read a final one after a higher digit as เอ็ด.
- [Unicode CLDR: Thai Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/th.xml): The spell-out rules ICU uses to write numbers in words.
