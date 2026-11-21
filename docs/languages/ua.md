# Ukrainian (`ua`)

Українська.

## Examples

```ruby
I18n.with_locale(:ua) { 0.to_words }
# => "нуль"

I18n.with_locale(:ua) { 21.to_words }
# => "двадцять один"

I18n.with_locale(:ua) { 231.to_words }
# => "двісті тридцять один"

I18n.with_locale(:ua) { 4030.to_words }
# => "чотири тисячі тридцять"

I18n.with_locale(:ua) { 1_000_100.to_words }
# => "один мільйон сто"

I18n.with_locale(:ua) { 2_000_000_000.to_words }
# => "два мільярди"

I18n.with_locale(:ua) { [1, 2, 3].to_words }
# => ["один", "два", "три"]

I18n.with_locale(:ua) { [11, 22, 133].to_words }
# => ["одинадцять", "двадцять два", "сто тридцять три"]

I18n.with_locale(:ua) { 21.77.to_words }
# => "двадцять одна ціла і сімдесят сім сотих"
```

## Gender

`gender: :male` (default), :female or :neuter

```ruby
I18n.with_locale(:ua) { 1001.to_words(gender: :female) }
# => "одна тисяча одна"

I18n.with_locale(:ua) { 1001.to_words(gender: :neuter) }
# => "одна тисяча одне"
```
