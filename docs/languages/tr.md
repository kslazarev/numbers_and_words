# Turkish (`tr`)

Türkçe.

## Examples

```ruby
I18n.with_locale(:tr) { 0.to_words }
# => "sıfır"

I18n.with_locale(:tr) { 21.to_words }
# => "yirmi bir"

I18n.with_locale(:tr) { 231.to_words }
# => "iki yüz otuz bir"

I18n.with_locale(:tr) { 4030.to_words }
# => "dört bin otuz"

I18n.with_locale(:tr) { 1_000_100.to_words }
# => "bir milyon yüz"

I18n.with_locale(:tr) { 2_000_000_000.to_words }
# => "iki milyar"

I18n.with_locale(:tr) { [1, 2, 3].to_words }
# => ["bir", "iki", "üç"]

I18n.with_locale(:tr) { [11, 22, 133].to_words }
# => ["on bir", "yirmi iki", "yüz otuz üç"]
```

## Decimals

Decimals are not supported yet.

## Options

### Precision

`precision` pads the fractional part of a decimal, so it has no effect until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal, so it has no effect until decimals are supported.
