# Italian (`it`)

Italiano. This language is experimental: one million and larger scales read `uno milione` instead of `un milione`.

Aliases: `it-CH`.

## Examples

```ruby
I18n.with_locale(:it) { 0.to_words }
# => "zero"

I18n.with_locale(:it) { 21.to_words }
# => "ventuno"

I18n.with_locale(:it) { 231.to_words }
# => "duecentotrentuno"

I18n.with_locale(:it) { 4030.to_words }
# => "quattromilatrenta"

I18n.with_locale(:it) { 1_000_100.to_words }
# => "uno milione cento"

I18n.with_locale(:it) { 2_000_000_000.to_words }
# => "due miliardi"

I18n.with_locale(:it) { [1, 2, 3].to_words }
# => ["uno", "due", "tre"]

I18n.with_locale(:it) { [11, 22, 133].to_words }
# => ["undici", "ventidue", "centotrentatré"]

I18n.with_locale(:it) { 21.77.to_words }
# => "ventuno e settantasette centesimi"
```

## Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:it) { 0.7.to_words(remove_zero: true) }
# => "sette decimi"
```
