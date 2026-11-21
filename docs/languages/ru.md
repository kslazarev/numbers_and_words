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
```

## Decimals

```ruby
I18n.with_locale(:ru) { 21.77.to_words }
# => "двадцать одна целая и семьдесят семь сотых"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:ru) { 0.1.to_words(precision: 2) }
# => "ноль целых и десять сотых"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ru) { 21.77.to_words(micro_separator: "plus") }
# => "двадцать одна целая plus семьдесят семь сотых"
```

### Gender

`gender: :male` (default), :female or :neuter

```ruby
I18n.with_locale(:ru) { 1001.to_words(gender: :female) }
# => "одна тысяча одна"

I18n.with_locale(:ru) { 1001.to_words(gender: :neuter) }
# => "одна тысяча одно"
```

### Ordinal

`ordinal: true` makes the last word ordinal ("двадцать первый") and joins a round thousand or million to its multiplier ("двухтысячный"). `gender:` selects the masculine, feminine or neuter ending.

```ruby
I18n.with_locale(:ru) { 1.to_words(ordinal: true) }
# => "первый"

I18n.with_locale(:ru) { 21.to_words(ordinal: true) }
# => "двадцать первый"

I18n.with_locale(:ru) { 2_000.to_words(ordinal: true) }
# => "двухтысячный"

I18n.with_locale(:ru) { 21.to_words(ordinal: true, gender: :female) }
# => "двадцать первая"
```

### Case

`case:` declines an ordinal: `:nominative` (default), `:genitive`, `:dative`, `:accusative`, `:instrumental` or `:prepositional`. Only the last word declines ("двадцать первого"), in the ending `gender:` selects.

```ruby
I18n.with_locale(:ru) { 21.to_words(ordinal: true, case: :genitive) }
# => "двадцать первого"

I18n.with_locale(:ru) { 123.to_words(ordinal: true, case: :dative) }
# => "сто двадцать третьему"

I18n.with_locale(:ru) { 21.to_words(ordinal: true, gender: :female, case: :dative) }
# => "двадцать первой"

I18n.with_locale(:ru) { 3.to_words(ordinal: true, gender: :female, case: :accusative) }
# => "третью"

I18n.with_locale(:ru) { 2_000.to_words(ordinal: true, case: :prepositional) }
# => "двухтысячном"
```

Cardinals and decimals are not declined yet: `case:` other than `:nominative` raises `NumbersAndWords::UnsupportedOptionError` without `ordinal: true`.

### Animate

`animate: true` gives the masculine accusative the genitive form, as for an animate noun ("вижу двадцать первого"); the default is the inanimate form, the same as the nominative.

```ruby
I18n.with_locale(:ru) { 21.to_words(ordinal: true, case: :accusative) }
# => "двадцать первый"

I18n.with_locale(:ru) { 21.to_words(ordinal: true, case: :accusative, animate: true) }
# => "двадцать первого"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:ru) { 0.7.to_words(remove_zero: true) }
# => "семь десятых"
```
