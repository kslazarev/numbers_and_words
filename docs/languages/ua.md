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
```

## Decimals

```ruby
I18n.with_locale(:ua) { 21.77.to_words }
# => "двадцять одна ціла і сімдесят сім сотих"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:ua) { 0.1.to_words(precision: 2) }
# => "нуль цілих і десять сотих"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ua) { 21.77.to_words(micro_separator: "plus") }
# => "двадцять одна ціла plus сімдесят сім сотих"
```

### Gender

`gender: :male` (default), :female or :neuter

```ruby
I18n.with_locale(:ua) { 1001.to_words(gender: :female) }
# => "одна тисяча одна"

I18n.with_locale(:ua) { 1001.to_words(gender: :neuter) }
# => "одна тисяча одне"
```

### Ordinal

`ordinal: true` makes the last word ordinal ("двадцять перший") and joins a round thousand or million to its multiplier ("двохтисячний"). `gender:` selects the masculine, feminine or neuter ending.

```ruby
I18n.with_locale(:ua) { 1.to_words(ordinal: true) }
# => "перший"

I18n.with_locale(:ua) { 21.to_words(ordinal: true) }
# => "двадцять перший"

I18n.with_locale(:ua) { 2_000.to_words(ordinal: true) }
# => "двохтисячний"

I18n.with_locale(:ua) { 21.to_words(ordinal: true, gender: :female) }
# => "двадцять перша"
```

### Case

`case:` declines an ordinal: `:nominative` (default), `:genitive`, `:dative`, `:accusative`, `:instrumental`, `:prepositional` (місцевий) or `:vocative`. Only the last word declines ("двадцять першого"), in the ending `gender:` selects; the vocative of an ordinal is the same as its nominative.

```ruby
I18n.with_locale(:ua) { 21.to_words(ordinal: true, case: :genitive) }
# => "двадцять першого"

I18n.with_locale(:ua) { 123.to_words(ordinal: true, case: :dative) }
# => "сто двадцять третьому"

I18n.with_locale(:ua) { 21.to_words(ordinal: true, gender: :female, case: :genitive) }
# => "двадцять першої"

I18n.with_locale(:ua) { 3.to_words(ordinal: true, gender: :female, case: :instrumental) }
# => "третьою"

I18n.with_locale(:ua) { 2_000.to_words(ordinal: true, case: :prepositional) }
# => "двохтисячному"

I18n.with_locale(:ua) { 1.to_words(ordinal: true, case: :vocative) }
# => "перший"
```

Cardinals and decimals are not declined yet: `case:` other than `:nominative` raises `NumbersAndWords::UnsupportedOptionError` without `ordinal: true`.

### Animate

`animate: true` gives the masculine accusative the genitive form, as for an animate noun ("бачу двадцять першого"); the default is the inanimate form, the same as the nominative.

```ruby
I18n.with_locale(:ua) { 21.to_words(ordinal: true, case: :accusative) }
# => "двадцять перший"

I18n.with_locale(:ua) { 21.to_words(ordinal: true, case: :accusative, animate: true) }
# => "двадцять першого"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:ua) { 0.7.to_words(remove_zero: true) }
# => "сім десятих"
```
