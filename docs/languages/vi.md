# Vietnamese (`vi`)

Tiếng Việt.

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

```ruby
I18n.with_locale(:vi) { 21.77.to_words }
# => "hai mươi mốt phẩy bảy mươi bảy"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:vi) { 0.1.to_words(precision: 2) }
# => "không phẩy mười"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:vi) { 21.77.to_words(micro_separator: "plus") }
# => "hai mươi mốt plus bảy mươi bảy"
```

### Ordinal

`ordinal: true` puts thứ before the number, with nhất for 1 and tư for 4.

```ruby
I18n.with_locale(:vi) { 1.to_words(ordinal: true) }
# => "thứ nhất"

I18n.with_locale(:vi) { 4.to_words(ordinal: true) }
# => "thứ tư"

I18n.with_locale(:vi) { 21.to_words(ordinal: true) }
# => "thứ hai mươi mốt"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:vi) { 0.7.to_words(remove_zero: true) }
# => "phẩy bảy"
```
