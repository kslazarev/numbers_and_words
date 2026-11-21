# Brazilian Portuguese (`pt-BR`)

Português Brasileiro.

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

I18n.with_locale(:'pt-BR') { 21.77.to_words }
# => "vinte e um inteiros e setenta e sete centésimos"
```

## Gender

`gender: :male` (default) or :female

```ruby
I18n.with_locale(:'pt-BR') { 1_000_000_001.to_words(gender: :female) }
# => "um bilhão e uma"
```

## Ordinal

`ordinal: true`

```ruby
I18n.with_locale(:'pt-BR') { 21.to_words(ordinal: true) }
# => "vigésimo primeiro"
```

## Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:'pt-BR') { 0.7.to_words(remove_zero: true) }
# => "sete décimos"
```
