# French (`fr`)

Français.

Aliases: `fr-CA`.

## Examples

```ruby
I18n.with_locale(:fr) { 0.to_words }
# => "zéro"

I18n.with_locale(:fr) { 21.to_words }
# => "vingt-et-un"

I18n.with_locale(:fr) { 231.to_words }
# => "deux-cent-trente-et-un"

I18n.with_locale(:fr) { 4030.to_words }
# => "quatre-mille-trente"

I18n.with_locale(:fr) { 1_000_100.to_words }
# => "un million cent"

I18n.with_locale(:fr) { 2_000_000_000.to_words }
# => "deux milliards"

I18n.with_locale(:fr) { [1, 2, 3].to_words }
# => ["un", "deux", "trois"]

I18n.with_locale(:fr) { [11, 22, 133].to_words }
# => ["onze", "vingt-deux", "cent-trente-trois"]

I18n.with_locale(:fr) { 21.77.to_words }
# => "vingt-et-un et soixante-dix-sept centièmes"
```

## Traditional Spelling

French follows the 1990 spelling reform by default, hyphenating every numeral in a compound number except the nouns million, milliard and larger. `traditional: true` gives the earlier spelling.

```ruby
I18n.with_locale(:fr) { 321.to_words }
# => "trois-cent-vingt-et-un"

I18n.with_locale(:fr) { 2_000_021.to_words }
# => "deux millions vingt-et-un"

I18n.with_locale(:fr) { 321.to_words(traditional: true) }
# => "trois cent vingt et un"
```
