# Russian (`ru`)

Русский.

## Examples

```ruby
I18n.with_locale(:ru) { 0.to_words }
# => "ноль"

I18n.with_locale(:ru) { 21.to_words }
# => "двадцать один"

I18n.with_locale(:ru) { 231.to_words }
# => "двести тридцать один"

I18n.with_locale(:ru) { 4030.to_words }
# => "четыре тысячи тридцать"

I18n.with_locale(:ru) { 1_000_100.to_words }
# => "один миллион сто"

I18n.with_locale(:ru) { 2_000_000_000.to_words }
# => "два миллиарда"

I18n.with_locale(:ru) { [1, 2, 3].to_words }
# => ["один", "два", "три"]

I18n.with_locale(:ru) { [11, 22, 133].to_words }
# => ["одиннадцать", "двадцать два", "сто тридцать три"]

I18n.with_locale(:ru) { 21.77.to_words }
# => "двадцать одна целая и семьдесят семь сотых"
```

## Gender

`gender: :male` (default), :female or :neuter

```ruby
I18n.with_locale(:ru) { 1001.to_words(gender: :female) }
# => "одна тысяча одна"

I18n.with_locale(:ru) { 1001.to_words(gender: :neuter) }
# => "одна тысяча одно"
```
