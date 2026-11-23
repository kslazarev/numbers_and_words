# Brazilian Portuguese (`pt-BR`)

Português brasileiro is the Brazilian Portuguese name of the language. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

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

Decimals are read as a fraction. [`fraction: false`](#fraction), the default in 2.0, reads them with `vírgula`.

```ruby
I18n.with_locale(:'pt-BR') { 21.77.to_words }
# => "vinte e um inteiros e setenta e sete centésimos"

I18n.with_locale(:'pt-BR') { 3.05.to_words }
# => "três inteiros e cinco centésimos"

I18n.with_locale(:'pt-BR') { 3.1416.to_words }
# => "três inteiros e mil quatrocentos e dezesseis décimos de milésimo"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:'pt-BR') { 0.1.to_words(precision: 2) }
# => "zero inteiros e dez centésimos"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:'pt-BR') { 21.77.to_words(micro_separator: 'plus') }
# => "vinte e um inteiros plus setenta e sete centésimos"
```

### Fraction

The `fraction: true` option, the default, reads decimals as a fraction. The `fraction: false` option reads them with `vírgula`: up to six decimal places as a number, after a `zero` for each leading zero, and longer ones digit by digit. It becomes the default in 2.0, and the gem warns about the change (see [UPGRADING](../../UPGRADING.md)).

```ruby
I18n.with_locale(:'pt-BR') { 21.77.to_words(fraction: false) }
# => "vinte e um vírgula setenta e sete"

I18n.with_locale(:'pt-BR') { 3.05.to_words(fraction: false) }
# => "três vírgula zero cinco"

I18n.with_locale(:'pt-BR') { 3.1416.to_words(fraction: false) }
# => "três vírgula mil quatrocentos e dezesseis"
```

### Gender

The `gender` option takes `:male` (default) or `:female`. Mil agrees with what is counted (duzentas mil). Milhão and larger scale nouns, and inteiro and décimo in fractions, are masculine (dois milhões, dois inteiros e dois décimos).

```ruby
I18n.with_locale(:'pt-BR') { 1_000_000_001.to_words(gender: :female) }
# => "um bilhão e uma"

I18n.with_locale(:'pt-BR') { 2_000_000.to_words(gender: :female) }
# => "dois milhões"

I18n.with_locale(:'pt-BR') { 21_000.to_words(gender: :female) }
# => "vinte e uma mil"
```

### Ordinal

The `ordinal: true` option reads a lone thousand, million or larger scale without a leading primeiro (milésimo, milionésimo primeiro).

```ruby
I18n.with_locale(:'pt-BR') { 21.to_words(ordinal: true) }
# => "vigésimo primeiro"

I18n.with_locale(:'pt-BR') { 1_000_001.to_words(ordinal: true) }
# => "milionésimo primeiro"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part. The usual reading is with a decimal point: "zero vírgula sete" with `fraction: false`.

```ruby
I18n.with_locale(:'pt-BR') { 0.7.to_words(remove_zero: true) }
# => "sete décimos"
```

## Sources

- [Clube do Português: Commas in Written-Out Numbers](https://www.clubedoportugues.com.br/virgula-com-numeros-por-extenso/): The differing conventions for separating number classes.
- [Estadão Style Manual: Written-Out Numbers](https://www.estadao.com.br/manualredacao/esclareca/numerosporextenso): Class separators and joining with e.
- [Brasil Escola: Written-Out Numbers](https://brasilescola.uol.com.br/gramatica/numeros-por-extenso.htm): Cardinal spelling and conjunctions.
- [Unicode CLDR: Brazilian Portuguese Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/pt.xml): The spell-out rules ICU uses to write numbers in words.
