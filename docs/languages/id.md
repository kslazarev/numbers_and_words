# Indonesian (`id`)

Bahasa Indonesia.

One ten, hundred or thousand takes the prefix se- (sepuluh, sebelas, seratus, seribu), and larger scales keep satu (satu juta, satu miliar). Teens are formed with belas (dua belas), tens with puluh (dua puluh satu) and hundreds with ratus (dua ratus). Scale words follow the short scale, from miliar (10<sup>9</sup>) and triliun (10<sup>12</sup>) through kuadriliun, kuintiliun, sekstiliun, septiliun, oktiliun, noniliun and desiliun (10<sup>33</sup>). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:id) { 0.to_words }
# => "nol"

I18n.with_locale(:id) { 11.to_words }
# => "sebelas"

I18n.with_locale(:id) { 21.to_words }
# => "dua puluh satu"

I18n.with_locale(:id) { 111.to_words }
# => "seratus sebelas"

I18n.with_locale(:id) { 1_001.to_words }
# => "seribu satu"

I18n.with_locale(:id) { 21_000.to_words }
# => "dua puluh satu ribu"

I18n.with_locale(:id) { 1_000_000.to_words }
# => "satu juta"

I18n.with_locale(:id) { 2_000_000_000.to_words }
# => "dua miliar"

I18n.with_locale(:id) { [1, 2, 3].to_words }
# => ["satu", "dua", "tiga"]
```

## Decimals

Decimals are read with `koma` followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:id) { 3.14.to_words }
# => "tiga koma satu empat"

I18n.with_locale(:id) { 21.05.to_words }
# => "dua puluh satu koma nol lima"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:id) { 0.1.to_words(precision: 2) }
# => "nol koma satu nol"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:id) { 21.77.to_words(micro_separator: "titik") }
# => "dua puluh satu titik tujuh tujuh"
```

### Ordinal

`ordinal: true` adds the prefix ke- (kedua, kesebelas, kedua puluh satu), except `pertama` for 1. Zero keeps its cardinal form.

```ruby
I18n.with_locale(:id) { 1.to_words(ordinal: true) }
# => "pertama"

I18n.with_locale(:id) { 21.to_words(ordinal: true) }
# => "kedua puluh satu"

I18n.with_locale(:id) { 100.to_words(ordinal: true) }
# => "keseratus"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:id) { 0.7.to_words(remove_zero: true) }
# => "koma tujuh"
```

## Sources

- [EYD: Numerals and Numbers](https://ejaan.kemendikdasmen.go.id/eyd/penulisan-kata/angka-dan-bilangan/): Official Indonesian numeral spelling rules.
- [KBBI: miliar](https://kbbi.kemendikdasmen.go.id/entri/miliar): The billion scale word.
- [KBBI: triliun](https://kbbi.kemendikdasmen.go.id/entri/triliun): The trillion scale word.
- [KBBI: desiliun](https://kbbi.kemendikdasmen.go.id/entri/desiliun): The 10<sup>33</sup> scale word, in the American (short) scale.
- [Unicode CLDR: Indonesian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/id.xml): The spell-out rules ICU uses to write numbers in words.
