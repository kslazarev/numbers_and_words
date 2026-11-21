# Latvian (`lv`)

Latviešu.

## Examples

```ruby
I18n.with_locale(:lv) { 0.to_words }
# => "nulle"

I18n.with_locale(:lv) { 21.to_words }
# => "divdesmit viens"

I18n.with_locale(:lv) { 231.to_words }
# => "divi simti trīsdesmit viens"

I18n.with_locale(:lv) { 4030.to_words }
# => "četri tūkstoši trīsdesmit"

I18n.with_locale(:lv) { 1_000_100.to_words }
# => "viens miljons viens simts"

I18n.with_locale(:lv) { 2_000_000_000.to_words }
# => "divi miljardi"

I18n.with_locale(:lv) { [1, 2, 3].to_words }
# => ["viens", "divi", "trīs"]

I18n.with_locale(:lv) { [11, 22, 133].to_words }
# => ["vienpadsmit", "divdesmit divi", "viens simts trīsdesmit trīs"]
```

Decimals are not supported yet.
