# Armenian (`hy`)

Հայերեն.

## Examples

```ruby
I18n.with_locale(:hy) { 0.to_words }
# => "զրո"

I18n.with_locale(:hy) { 21.to_words }
# => "քսանմեկ"

I18n.with_locale(:hy) { 231.to_words }
# => "երկու հարյուր երեսունմեկ"

I18n.with_locale(:hy) { 4030.to_words }
# => "չորս հազար երեսուն"

I18n.with_locale(:hy) { 1_000_100.to_words }
# => "մեկ միլիոն հարյուր"

I18n.with_locale(:hy) { 2_000_000_000.to_words }
# => "երկու միլիարդ"

I18n.with_locale(:hy) { [1, 2, 3].to_words }
# => ["մեկ", "երկու", "երեք"]

I18n.with_locale(:hy) { [11, 22, 133].to_words }
# => ["տասնմեկ", "քսաներկու", "հարյուր երեսուներեք"]
```

Decimals are not supported yet.
