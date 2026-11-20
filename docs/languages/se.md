# Swedish (`se`)

Svenska. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

## Examples

```ruby
I18n.with_locale(:se) { 0.to_words }
# => "noll"

I18n.with_locale(:se) { 21.to_words }
# => "tjugoett"

I18n.with_locale(:se) { 231.to_words }
# => "tvåhundratrettioett"

I18n.with_locale(:se) { 4030.to_words }
# => "fyratusentrettio"

I18n.with_locale(:se) { 1_000_100.to_words }
# => "en miljon etthundra"

I18n.with_locale(:se) { 2_000_000_000.to_words }
# => "två miljarder"

I18n.with_locale(:se) { [1, 2, 3].to_words }
# => ["ett", "två", "tre"]

I18n.with_locale(:se) { [11, 22, 133].to_words }
# => ["elva", "tjugotvå", "etthundratrettiotre"]
```

Decimals are not supported yet.
