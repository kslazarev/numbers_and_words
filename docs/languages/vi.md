# Vietnamese (`vi`)

Tiếng Việt is the Vietnamese name of the language. From a billion on, numbers count tỷ, so larger scales compound it: nghìn tỷ (10<sup>12</sup>), triệu tỷ (10<sup>15</sup>), tỷ tỷ (10<sup>18</sup>), nghìn tỷ tỷ, triệu tỷ tỷ, tỷ tỷ tỷ (10<sup>27</sup>) and so on. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:vi) { 0.to_words }
# => "không"

I18n.with_locale(:vi) { 21.to_words }
# => "hai mươi mốt"

I18n.with_locale(:vi) { 231.to_words }
# => "hai trăm ba mươi mốt"

I18n.with_locale(:vi) { 4030.to_words }
# => "bốn nghìn không trăm ba mươi"

I18n.with_locale(:vi) { 1_000_100.to_words }
# => "một triệu một trăm"

I18n.with_locale(:vi) { 2_000_000_000.to_words }
# => "hai tỷ"

I18n.with_locale(:vi) { [1, 2, 3].to_words }
# => ["một", "hai", "ba"]

I18n.with_locale(:vi) { [11, 22, 133].to_words }
# => ["mười một", "hai mươi hai", "một trăm ba mươi ba"]
```

## Decimals

Decimals are read with `phẩy`, one `không` for each leading zero, and the remaining fractional part as a number. The digit-by-digit reading, also valid after a leading zero, isn't used.

```ruby
I18n.with_locale(:vi) { 0.05.to_words }
# => "không phẩy không năm"

I18n.with_locale(:vi) { 0.012.to_words }
# => "không phẩy không mười hai"

I18n.with_locale(:vi) { 0.0012.to_words }
# => "không phẩy không không mười hai"

I18n.with_locale(:vi) { 21.77.to_words }
# => "hai mươi mốt phẩy bảy mươi bảy"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:vi) { 0.1.to_words(precision: 2) }
# => "không phẩy mười"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:vi) { 21.77.to_words(micro_separator: 'plus') }
# => "hai mươi mốt plus bảy mươi bảy"
```

### Ordinal

The `ordinal: true` option puts thứ before the number, with nhất for 1 and tư for 4.

```ruby
I18n.with_locale(:vi) { 1.to_words(ordinal: true) }
# => "thứ nhất"

I18n.with_locale(:vi) { 4.to_words(ordinal: true) }
# => "thứ tư"

I18n.with_locale(:vi) { 21.to_words(ordinal: true) }
# => "thứ hai mươi mốt"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part.

```ruby
I18n.with_locale(:vi) { 0.7.to_words(remove_zero: true) }
# => "phẩy bảy"
```

## Sources

- [Mathnasium: Decimal Numbers](https://mathnasium.edu.vn/uu-dai/so-thap-phan-lop-5-cach-doc-viet-so-sanh-va-bai-tap/): Numeric fractional readings and leading zeros.
- [Navi: Decimal Numbers](https://navi.edu.vn/goc-kham-pha/toan/don-vi-kien-thuc/60057170384781568/so-thap-phan): Numeric and digit-by-digit reading conventions.
- [VietJack: Decimal Place Values](https://vietjack.me/ly-thuyet-hang-cua-so-thap-phan-doc-viet-so-thap-phan-moi-2024-bai-tap-229422.html): Place-value-based decimal readings.
- [Wikipedia: Vietnamese Numerals](https://en.wikipedia.org/wiki/Vietnamese_numerals): Large numbers compounded from tỷ, such as nghìn tỷ, triệu tỷ and tỷ tỷ.
- [Unicode CLDR: Vietnamese Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/vi.xml): The spell-out rules ICU uses to write numbers in words.
