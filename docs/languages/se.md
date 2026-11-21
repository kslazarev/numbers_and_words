# Swedish (`se`)

Svenska. This language is experimental: compounds and scale words are not yet correct Swedish (`en miljoner en hundra`).

## Examples

```ruby
I18n.with_locale(:se) { 0.to_words }
# => "noll"

I18n.with_locale(:se) { 21.to_words }
# => "tjugo-en"

I18n.with_locale(:se) { 231.to_words }
# => "två hundra trettio-en"

I18n.with_locale(:se) { 4030.to_words }
# => "fyra tusen trettio"

I18n.with_locale(:se) { 1_000_100.to_words }
# => "en miljoner en hundra"

I18n.with_locale(:se) { 2_000_000_000.to_words }
# => "två miljarder"

I18n.with_locale(:se) { [1, 2, 3].to_words }
# => ["en", "två", "tre"]

I18n.with_locale(:se) { [11, 22, 133].to_words }
# => ["elva", "tjugo-två", "en hundra trettio-tre"]
```

Decimals are not supported yet.
