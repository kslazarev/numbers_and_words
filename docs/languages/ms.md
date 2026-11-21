# Malay (`ms`)

Bahasa Melayu. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Malay counts like Indonesian with its own words: lapan for 8, bilion and trilion for 10<sup>9</sup> and 10<sup>12</sup>, and the formal sifar for zero (kosong is common in speech). One ten, hundred or thousand takes the prefix se- (sepuluh, sebelas, seratus, seribu), and larger scales keep satu (satu juta). Numbers up to 999,999,999,999,999 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:ms) { 0.to_words }
# => "sifar"

I18n.with_locale(:ms) { 11.to_words }
# => "sebelas"

I18n.with_locale(:ms) { 28.to_words }
# => "dua puluh lapan"

I18n.with_locale(:ms) { 111.to_words }
# => "seratus sebelas"

I18n.with_locale(:ms) { 1_001.to_words }
# => "seribu satu"

I18n.with_locale(:ms) { 1_000_000.to_words }
# => "satu juta"

I18n.with_locale(:ms) { 2_000_000_000.to_words }
# => "dua bilion"

I18n.with_locale(:ms) { [1, 2, 3].to_words }
# => ["satu", "dua", "tiga"]
```

## Decimals

Decimals are read with `perpuluhan` followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:ms) { 3.14.to_words }
# => "tiga perpuluhan satu empat"

I18n.with_locale(:ms) { 21.05.to_words }
# => "dua puluh satu perpuluhan sifar lima"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:ms) { 0.1.to_words(precision: 2) }
# => "sifar perpuluhan satu sifar"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ms) { 21.77.to_words(micro_separator: "titik") }
# => "dua puluh satu titik tujuh tujuh"
```

### Ordinal

`ordinal: true` adds the prefix ke- (kedua, kesebelas, kedua puluh satu), except `pertama` for 1. Zero keeps its cardinal form.

```ruby
I18n.with_locale(:ms) { 1.to_words(ordinal: true) }
# => "pertama"

I18n.with_locale(:ms) { 21.to_words(ordinal: true) }
# => "kedua puluh satu"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:ms) { 0.7.to_words(remove_zero: true) }
# => "perpuluhan tujuh"
```
