# Turkish (`tr`)

Türkçe. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

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

Decimals are not supported yet. Converting a float, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("decimals are not supported in :tr").

## Options

### Precision

`precision` pads the fractional part of a decimal; floats raise `NumbersAndWords::UnsupportedNumberError` until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal; floats raise `NumbersAndWords::UnsupportedNumberError` until decimals are supported.

### Ordinal

`ordinal: true` adds -inci to the last word, following vowel harmony ("yirmi birinci", "dokuzuncu").

```ruby
I18n.with_locale(:tr) { 1.to_words(ordinal: true) }
# => "birinci"

I18n.with_locale(:tr) { 21.to_words(ordinal: true) }
# => "yirmi birinci"

I18n.with_locale(:tr) { 2_000.to_words(ordinal: true) }
# => "iki bininci"
```
