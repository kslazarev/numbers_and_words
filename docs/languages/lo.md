# Lao (`lo`)

ພາສາລາວ is the Lao name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are written without spaces. Lao numbers have no gender.

Each group of up to six digits uses the places ສິບ (10), ຮ້ອຍ (100), ພັນ (1,000), ໝື່ນ (10,000) and ແສນ (100,000). ລ້ານ (1,000,000) repeats for larger numbers, so 10<sup>9</sup> is ໜຶ່ງພັນລ້ານ and 10<sup>12</sup> is ໜຶ່ງລ້ານລ້ານ; there is no limit. 20 is ຊາວ. As in the Unicode CLDR rules, a final 1 after a ten is ເອັດ (ສິບເອັດ, ຊາວເອັດ), while 1 after a hundred or a larger place stays ໜຶ່ງ (ໜຶ່ງຮ້ອຍໜຶ່ງ).

The gem doesn't produce these common alternatives, which need a native speaker's review: ສິບພັນ for 10,000 and ຮ້ອຍພັນ for 100,000, ຕື້ for 10<sup>9</sup>, and ຮ້ອຍ, ພັນ without ໜຶ່ງ. The readings from 10<sup>18</sup> on, past the Unicode CLDR rules, keep repeating ລ້ານ. The CLDR Lao rules write zero, the places from a hundred, minus, the decimal point and the ordinal prefix with Thai words (ศูนย์, ร้อย, พัน, หมื่น, แสน, ล้าน, ลบ, จุด, ที่); the gem uses the Lao words.

## Examples

```ruby
I18n.with_locale(:lo) { 0.to_words }
# => "ສູນ"

I18n.with_locale(:lo) { 21.to_words }
# => "ຊາວເອັດ"

I18n.with_locale(:lo) { 101.to_words }
# => "ໜຶ່ງຮ້ອຍໜຶ່ງ"

I18n.with_locale(:lo) { 123_456.to_words }
# => "ໜຶ່ງແສນສອງໝື່ນສາມພັນສີ່ຮ້ອຍຫ້າສິບຫົກ"

I18n.with_locale(:lo) { 21_000_000.to_words }
# => "ຊາວເອັດລ້ານ"

I18n.with_locale(:lo) { 1_000_000_000.to_words }
# => "ໜຶ່ງພັນລ້ານ"

I18n.with_locale(:lo) { 1_000_000_000_000.to_words }
# => "ໜຶ່ງລ້ານລ້ານ"

I18n.with_locale(:lo) { -5.to_words }
# => "ລົບຫ້າ"

I18n.with_locale(:lo) { [11, 22, 133].to_words }
# => ["ສິບເອັດ", "ຊາວສອງ", "ໜຶ່ງຮ້ອຍສາມສິບສາມ"]
```

## Decimals

Decimals are read with ຈຸດ followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:lo) { 3.14.to_words }
# => "ສາມຈຸດໜຶ່ງສີ່"

I18n.with_locale(:lo) { 21.05.to_words }
# => "ຊາວເອັດຈຸດສູນຫ້າ"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:lo) { 0.1.to_words(precision: 2) }
# => "ສູນຈຸດໜຶ່ງສູນ"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:lo) { 21.77.to_words(micro_separator: "plus") }
# => "ຊາວເອັດplusເຈັດເຈັດ"
```

### Ordinal

With `ordinal: true`, the prefix ທີ is added to integers of any size.

```ruby
I18n.with_locale(:lo) { 1.to_words(ordinal: true) }
# => "ທີໜຶ່ງ"

I18n.with_locale(:lo) { 21.to_words(ordinal: true) }
# => "ທີຊາວເອັດ"
```

### Remove Zero

With `remove_zero: true`, a zero integral part is omitted.

```ruby
I18n.with_locale(:lo) { 0.7.to_words(remove_zero: true) }
# => "ຈຸດເຈັດ"
```

## Sources

- [Wikipedia: Lao Script](https://en.wikipedia.org/wiki/Lao_script): The Lao numerals from zero to ten and twenty.
- [Unicode CLDR: Lao Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/lo.xml): The spell-out rules ICU uses to write numbers in words, with ເອັດ after a ten.
