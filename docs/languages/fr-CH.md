# Swiss French (`fr-CH`)

Français (Suisse).

## Examples

```ruby
I18n.with_locale(:'fr-CH') { 0.to_words }
# => "zéro"

I18n.with_locale(:'fr-CH') { 21.to_words }
# => "vingt-et-un"

I18n.with_locale(:'fr-CH') { 231.to_words }
# => "deux-cent-trente-et-un"

I18n.with_locale(:'fr-CH') { 4030.to_words }
# => "quatre-mille-trente"

I18n.with_locale(:'fr-CH') { 1_000_100.to_words }
# => "un million cent"

I18n.with_locale(:'fr-CH') { 2_000_000_000.to_words }
# => "deux milliards"

I18n.with_locale(:'fr-CH') { [1, 2, 3].to_words }
# => ["un", "deux", "trois"]

I18n.with_locale(:'fr-CH') { [11, 22, 133].to_words }
# => ["onze", "vingt-deux", "cent-trente-trois"]

I18n.with_locale(:'fr-CH') { 21.77.to_words }
# => "vingt-et-un et septante-sept centièmes"
```

## Traditional Spelling

Swiss French follows the 1990 spelling reform by default; `traditional: true` gives the earlier spelling.

```ruby
I18n.with_locale(:'fr-CH') { 71.to_words }
# => "septante-et-un"

I18n.with_locale(:'fr-CH') { 71.to_words(traditional: true) }
# => "septante et un"
```
