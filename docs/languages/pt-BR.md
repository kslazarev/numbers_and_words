# Brazilian Portuguese (`pt-BR`)

Português brasileiro. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:'pt-BR') { 0.to_words }
# => "zero"

I18n.with_locale(:'pt-BR') { 21.to_words }
# => "vinte e um"

I18n.with_locale(:'pt-BR') { 231.to_words }
# => "duzentos e trinta e um"

I18n.with_locale(:'pt-BR') { 4030.to_words }
# => "quatro mil e trinta"

I18n.with_locale(:'pt-BR') { 1_000_100.to_words }
# => "um milhão e cem"

I18n.with_locale(:'pt-BR') { 2_000_000_000.to_words }
# => "dois bilhões"

I18n.with_locale(:'pt-BR') { [1, 2, 3].to_words }
# => ["um", "dois", "três"]

I18n.with_locale(:'pt-BR') { [11, 22, 133].to_words }
# => ["onze", "vinte e dois", "cento e trinta e três"]
```

## Decimals

Decimals are read with `vírgula` followed by the fractional part: up to six decimal places as a number after one `zero` for each leading zero, and longer ones digit by digit.

```ruby
I18n.with_locale(:'pt-BR') { 21.77.to_words }
# => "vinte e um vírgula setenta e sete"

I18n.with_locale(:'pt-BR') { 3.05.to_words }
# => "três vírgula zero cinco"

I18n.with_locale(:'pt-BR') { 3.1416.to_words }
# => "três vírgula mil quatrocentos e dezesseis"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:'pt-BR') { 0.1.to_words(precision: 2) }
# => "zero vírgula dez"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:'pt-BR') { 21.77.to_words(micro_separator: "plus") }
# => "vinte e um plus setenta e sete"
```

### Fraction

`fraction: true` reads decimals as a fraction instead of with `vírgula`.

```ruby
I18n.with_locale(:'pt-BR') { 21.77.to_words(fraction: true) }
# => "vinte e um inteiros e setenta e sete centésimos"

I18n.with_locale(:'pt-BR') { 0.1.to_words(fraction: true) }
# => "zero inteiros e um décimo"
```

### Gender

`gender: :male` (default) or `gender: :female`. Mil agrees with what is counted (duzentas mil), but milhão and larger scale nouns, and inteiro and décimo in fractions, are masculine (dois milhões, dois inteiros e dois décimos).

```ruby
I18n.with_locale(:'pt-BR') { 1_000_000_001.to_words(gender: :female) }
# => "um bilhão e uma"

I18n.with_locale(:'pt-BR') { 2_000_000.to_words(gender: :female) }
# => "dois milhões"

I18n.with_locale(:'pt-BR') { 21_000.to_words(gender: :female) }
# => "vinte e uma mil"
```

### Ordinal

`ordinal: true`. A single thousand, million or larger scale is read without primeiro (milésimo, milionésimo primeiro).

```ruby
I18n.with_locale(:'pt-BR') { 21.to_words(ordinal: true) }
# => "vigésimo primeiro"

I18n.with_locale(:'pt-BR') { 1_000_001.to_words(ordinal: true) }
# => "milionésimo primeiro"
```

### Remove Zero

`remove_zero: true` omits a zero integral part. The default reading, "zero vírgula sete", is the usual one.

```ruby
I18n.with_locale(:'pt-BR') { 0.7.to_words(remove_zero: true) }
# => "vírgula sete"
```
