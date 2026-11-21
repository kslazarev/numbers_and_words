# Thai (`th`)

ภาษาไทย. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are written without spaces. Each group of up to six digits uses the places สิบ (10), ร้อย (100), พัน (1,000), หมื่น (10,000) and แสน (100,000), and ล้าน (1,000,000) repeats for larger numbers, so 10^12 is หนึ่งล้านล้าน. A final 1 is read เอ็ด when its group of six digits has other digits (101 is หนึ่งร้อยเอ็ด), and หนึ่ง otherwise (1,000,001 is หนึ่งล้านหนึ่ง).

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

I18n.with_locale(:th) { 2_000_000_000.to_words }
# => "สองพันล้าน"

I18n.with_locale(:th) { [1, 2, 3].to_words }
# => ["หนึ่ง", "สอง", "สาม"]

I18n.with_locale(:th) { [11, 22, 133].to_words }
# => ["สิบเอ็ด", "ยี่สิบสอง", "หนึ่งร้อยสามสิบสาม"]
```

## Ordinal

`ordinal: true` adds the prefix ที่ to integers.

```ruby
I18n.with_locale(:th) { 1.to_words(ordinal: true) }
# => "ที่หนึ่ง"

I18n.with_locale(:th) { 21.to_words(ordinal: true) }
# => "ที่ยี่สิบเอ็ด"
```

## Decimals

Decimals are read with จุด followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:th) { 3.14.to_words }
# => "สามจุดหนึ่งสี่"

I18n.with_locale(:th) { 21.05.to_words }
# => "ยี่สิบเอ็ดจุดศูนย์ห้า"
```
