# Portuguese (`pt`)

Português europeu. Brazilian Portuguese is [`pt-BR`](pt-BR.md).

European Portuguese uses the long scale: a new scale word every million (`milhão` 10⁶, `bilião` 10¹², `trilião` 10¹⁸, `quatrilião` 10²⁴, `quintilião` 10³⁰), with `mil` for the thousands in between (`mil milhões` is 10⁹, `mil biliões` 10¹⁵). `e` joins the last group of three digits to the rest when it is below one hundred or a round hundred (`mil e trinta`, `um milhão e duzentos mil`, but `mil cento e vinte`). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:pt) { 0.to_words }
# => "zero"

I18n.with_locale(:pt) { 16.to_words }
# => "dezasseis"

I18n.with_locale(:pt) { 21.to_words }
# => "vinte e um"

I18n.with_locale(:pt) { 231.to_words }
# => "duzentos e trinta e um"

I18n.with_locale(:pt) { 4030.to_words }
# => "quatro mil e trinta"

I18n.with_locale(:pt) { 1_000_100.to_words }
# => "um milhão e cem"

I18n.with_locale(:pt) { 2_000_000_000.to_words }
# => "dois mil milhões"

I18n.with_locale(:pt) { 1_174_315_110.to_words }
# => "mil cento e setenta e quatro milhões trezentos e quinze mil cento e dez"

I18n.with_locale(:pt) { 2_000_000_000_000.to_words }
# => "dois biliões"

I18n.with_locale(:pt) { [1, 2, 3].to_words }
# => ["um", "dois", "três"]

I18n.with_locale(:pt) { [11, 22, 133].to_words }
# => ["onze", "vinte e dois", "cento e trinta e três"]
```

## Decimals

Decimals are read with `vírgula` followed by the fractional part: up to three decimal places as a number after one `zero` for each leading zero, and longer ones digit by digit.

```ruby
I18n.with_locale(:pt) { 21.77.to_words }
# => "vinte e um vírgula setenta e sete"

I18n.with_locale(:pt) { 3.05.to_words }
# => "três vírgula zero cinco"

I18n.with_locale(:pt) { 3.1416.to_words }
# => "três vírgula um quatro um seis"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:pt) { 0.1.to_words(precision: 2) }
# => "zero vírgula dez"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:pt) { 21.77.to_words(micro_separator: "plus") }
# => "vinte e um plus setenta e sete"
```

### Fraction

`fraction: true` reads decimals as a fraction instead of with `vírgula`.

```ruby
I18n.with_locale(:pt) { 21.77.to_words(fraction: true) }
# => "vinte e um inteiros e setenta e sete centésimos"

I18n.with_locale(:pt) { 0.1.to_words(fraction: true) }
# => "zero inteiros e um décimo"

I18n.with_locale(:pt) { 0.000000001.to_words(fraction: true) }
# => "zero inteiros e um milésimo de milionésimo"
```

### Ordinal

`ordinal: true` makes every part of the number ordinal ("vigésimo primeiro"), including the multiplier of a scale word ("segundo milésimo"). Scale ordinals follow the long scale: `milésimo milionésimo` is 10⁹ and `bilionésimo` 10¹². Zero keeps its cardinal form.

```ruby
I18n.with_locale(:pt) { 1.to_words(ordinal: true) }
# => "primeiro"

I18n.with_locale(:pt) { 21.to_words(ordinal: true) }
# => "vigésimo primeiro"

I18n.with_locale(:pt) { 2_000.to_words(ordinal: true) }
# => "segundo milésimo"

I18n.with_locale(:pt) { 1_000_000_000_000.to_words(ordinal: true) }
# => "bilionésimo"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:pt) { 0.7.to_words(remove_zero: true) }
# => "vírgula sete"
```
