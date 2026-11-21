# Ukrainian (`uk`)

Українська. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:uk) { 0.to_words }
# => "нуль"

I18n.with_locale(:uk) { 21.to_words }
# => "двадцять один"

I18n.with_locale(:uk) { 231.to_words }
# => "двісті тридцять один"

I18n.with_locale(:uk) { 4030.to_words }
# => "чотири тисячі тридцять"

I18n.with_locale(:uk) { 1_000_100.to_words }
# => "один мільйон сто"

I18n.with_locale(:uk) { 2_000_000_000.to_words }
# => "два мільярди"

I18n.with_locale(:uk) { [1, 2, 3].to_words }
# => ["один", "два", "три"]

I18n.with_locale(:uk) { [11, 22, 133].to_words }
# => ["одинадцять", "двадцять два", "сто тридцять три"]
```

## Decimals

```ruby
I18n.with_locale(:uk) { 21.77.to_words }
# => "двадцять одна ціла і сімдесят сім сотих"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:uk) { 0.1.to_words(precision: 2) }
# => "нуль цілих і десять сотих"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:uk) { 21.77.to_words(micro_separator: "plus") }
# => "двадцять одна ціла plus сімдесят сім сотих"
```

### Gender

`gender: :male` (default), :female or :neuter

```ruby
I18n.with_locale(:uk) { 1001.to_words(gender: :female) }
# => "одна тисяча одна"

I18n.with_locale(:uk) { 1001.to_words(gender: :neuter) }
# => "одна тисяча одне"
```

### Ordinal

`ordinal: true` makes the last word ordinal ("двадцять перший") and joins a round thousand or million to its multiplier ("двохтисячний"). A thousand of one is read without одна ("тисяча перший"), as the cardinal keeps it ("одна тисяча один"). `gender:` selects the masculine, feminine or neuter ending.

```ruby
I18n.with_locale(:uk) { 1.to_words(ordinal: true) }
# => "перший"

I18n.with_locale(:uk) { 21.to_words(ordinal: true) }
# => "двадцять перший"

I18n.with_locale(:uk) { 2_000.to_words(ordinal: true) }
# => "двохтисячний"

I18n.with_locale(:uk) { 1001.to_words(ordinal: true) }
# => "тисяча перший"

I18n.with_locale(:uk) { 21.to_words(ordinal: true, gender: :female) }
# => "двадцять перша"
```

### Case

`case:` declines a number: `:nominative` (default), `:genitive`, `:dative`, `:accusative`, `:instrumental`, `:prepositional` (місцевий) or `:vocative`. Every word of a cardinal declines, and a scale word agrees with its numeral ("двадцяти однієї тисячі", "двох тисяч"). Only the last word of an ordinal declines ("двадцять першого"), in the ending `gender:` selects. The vocative is the same as the nominative.

```ruby
I18n.with_locale(:uk) { 21.to_words(case: :genitive) }
# => "двадцяти одного"

I18n.with_locale(:uk) { 21_000.to_words(case: :genitive) }
# => "двадцяти однієї тисячі"

I18n.with_locale(:uk) { 2_000.to_words(case: :dative) }
# => "двом тисячам"

I18n.with_locale(:uk) { 123_456.to_words(case: :instrumental) }
# => "ста двадцятьма трьома тисячами чотирмастами п’ятдесятьма шістьма"

I18n.with_locale(:uk) { 1_000.to_words(case: :accusative) }
# => "одну тисячу"

I18n.with_locale(:uk) { 21.to_words(ordinal: true, case: :genitive) }
# => "двадцять першого"

I18n.with_locale(:uk) { 123.to_words(ordinal: true, case: :dative) }
# => "сто двадцять третьому"

I18n.with_locale(:uk) { 21.to_words(ordinal: true, gender: :female, case: :genitive) }
# => "двадцять першої"

I18n.with_locale(:uk) { 3.to_words(ordinal: true, gender: :female, case: :instrumental) }
# => "третьою"

I18n.with_locale(:uk) { 2_000.to_words(ordinal: true, case: :prepositional) }
# => "двохтисячному"

I18n.with_locale(:uk) { 1.to_words(ordinal: true, case: :vocative) }
# => "перший"
```

Decimals are not declined: `case:` other than `:nominative` raises `NumbersAndWords::UnsupportedOptionError` for a decimal.

### Animate

`animate: true` gives the accusative the genitive form, as for an animate noun: for a masculine ordinal ("бачу двадцять першого"), for "один" ("двадцять одного"), and for "два", "три" and "чотири" alone ("двох"), while compound numbers ending in them keep the nominative ("двадцять два"). The default is the inanimate form.

```ruby
I18n.with_locale(:uk) { 21.to_words(ordinal: true, case: :accusative) }
# => "двадцять перший"

I18n.with_locale(:uk) { 21.to_words(ordinal: true, case: :accusative, animate: true) }
# => "двадцять першого"

I18n.with_locale(:uk) { 2.to_words(case: :accusative, animate: true) }
# => "двох"

I18n.with_locale(:uk) { 22.to_words(case: :accusative, animate: true) }
# => "двадцять два"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:uk) { 0.7.to_words(remove_zero: true) }
# => "сім десятих"
```
