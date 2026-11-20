# Portuguese (`pt`)

Português.

## Examples

```ruby
I18n.with_locale(:pt) { 0.to_words }
# => "zero"

I18n.with_locale(:pt) { 21.to_words }
# => "vinte e um"

I18n.with_locale(:pt) { 231.to_words }
# => "duzentos e trinta e um"

I18n.with_locale(:pt) { 4030.to_words }
# => "quatro mil trinta"

I18n.with_locale(:pt) { 1_000_100.to_words }
# => "um milhão cem"

I18n.with_locale(:pt) { 2_000_000_000.to_words }
# => "dois bilhões"

I18n.with_locale(:pt) { [1, 2, 3].to_words }
# => ["um", "dois", "três"]

I18n.with_locale(:pt) { [11, 22, 133].to_words }
# => ["onze", "vinte e dois", "cento e trinta e três"]

I18n.with_locale(:pt) { 21.77.to_words }
# => "vinte e um inteiros e setenta e sete centésimos"
```

## Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:pt) { 0.7.to_words(remove_zero: true) }
# => "sete décimos"
```
