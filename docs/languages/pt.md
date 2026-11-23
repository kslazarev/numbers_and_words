# Portuguese (`pt`)

Português europeu. Brazilian Portuguese is [`pt-BR`](pt-BR.md).

European Portuguese uses the long scale, with a new scale word every million: milhão (10<sup>6</sup>), bilião (10<sup>12</sup>), trilião (10<sup>18</sup>), quatrilião (10<sup>24</sup>) and quintilião (10<sup>30</sup>). Mil counts the thousands in between (mil milhões is 10<sup>9</sup>, mil biliões 10<sup>15</sup>). "e" joins the last group of three digits to the rest when it is below one hundred or a round hundred (mil e trinta, um milhão e duzentos mil, but mil cento e vinte). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

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

Decimals are read as a fraction. [`fraction: false`](#fraction), the default in 2.0, reads them with `vírgula`.

```ruby
I18n.with_locale(:pt) { 21.77.to_words }
# => "vinte e um inteiros e setenta e sete centésimos"

I18n.with_locale(:pt) { 3.05.to_words }
# => "três inteiros e cinco centésimos"

I18n.with_locale(:pt) { 3.1416.to_words }
# => "três inteiros e mil quatrocentos e dezasseis décimos de milésimo"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:pt) { 0.1.to_words(precision: 2) }
# => "zero inteiros e dez centésimos"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:pt) { 21.77.to_words(micro_separator: "plus") }
# => "vinte e um inteiros plus setenta e sete centésimos"
```

### Fraction

`fraction: true`, the default, reads decimals as a fraction. `fraction: false` reads them with `vírgula`: up to three decimal places as a number, after a `zero` for each leading zero, and longer ones digit by digit. It becomes the default in 2.0, and the gem warns about the change (see [UPGRADING](../../UPGRADING.md)).

```ruby
I18n.with_locale(:pt) { 21.77.to_words(fraction: false) }
# => "vinte e um vírgula setenta e sete"

I18n.with_locale(:pt) { 3.05.to_words(fraction: false) }
# => "três vírgula zero cinco"

I18n.with_locale(:pt) { 3.1416.to_words(fraction: false) }
# => "três vírgula um quatro um seis"

I18n.with_locale(:pt) { 0.000000001.to_words(fraction: true) }
# => "zero inteiros e um milésimo de milionésimo"
```

### Ordinal

`ordinal: true` makes every part of the number ordinal ("vigésimo primeiro"), including the multiplier of a scale word ("segundo milésimo"). Scale ordinals follow the long scale: milésimo milionésimo is 10<sup>9</sup> and bilionésimo 10<sup>12</sup>. Zero keeps its cardinal form.

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

### Gender

`gender: :male` (default) or `gender: :female`. The groups below a million agree with what is counted (duas mil, duzentas). Milhão and larger scale nouns, and inteiro and décimo in fractions, are masculine (dois milhões, dois inteiros e dois décimos). Ordinals take feminine endings (vigésima primeira). A [`unit`](../../README.md#unit) with `gender: female` sets it too.

```ruby
I18n.with_locale(:pt) { 2_222_222.to_words(gender: :female) }
# => "dois milhões duzentas e vinte e duas mil duzentas e vinte e duas"

I18n.with_locale(:pt) { 21.to_words(gender: :female, ordinal: true) }
# => "vigésima primeira"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:pt) { 0.7.to_words(remove_zero: true) }
# => "sete décimos"
```

## Sources

- [Collins: Cardinal and Ordinal Numbers](https://www.collinsdictionary.com/pt/grammar/aprendendo-gramática-português/cardinal-and-ordinal-numbers): Portuguese numeral forms.
- [Ciberdúvidas: Writing Large Ordinals](https://ciberduvidas.iscte-iul.pt/consultorio/perguntas/a-forma-por-extenso-de-2000font-facemicrosoft-sans-seriffont-e-de-outros-ordinais/16428): Large ordinal readings and accepted variants.
- [Unicode CLDR: Portuguese Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/pt_PT.xml): The spell-out rules ICU uses to write numbers in words.
