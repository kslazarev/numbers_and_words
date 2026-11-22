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

`precision` pads the fractional part with zeros to that many digits.

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

`ordinal: true` makes the last word ordinal ("двадцять перший") and joins a round thousand or million to its multiplier ("двохтисячний", "дев’яностотисячний"). A scale group of exactly one omits its one ("тисяча перший", "мільйон перший"), while cardinals keep it ("одна тисяча один", "один мільйон один"). Before мільйон and larger scales, this is the shorter of two readings; one that keeps один isn't wrong. `gender:` selects the masculine, feminine or neuter ending.

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

I18n.with_locale(:uk) { 90_000.to_words(ordinal: true) }
# => "дев’яностотисячний"

I18n.with_locale(:uk) { 1_000_001.to_words(ordinal: true) }
# => "мільйон перший"
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

`animate: true` gives the accusative its genitive form, as for an animate noun, instead of the default inanimate form. This applies to a masculine ordinal ("бачу двадцять першого"), "один" ("двадцять одного"), and "два", "три" and "чотири" alone ("двох"); compound numbers ending in them keep the nominative ("двадцять два").

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

## Sources

- [2019 Ukrainian Orthography, §36](https://slovnyk.ua/pravopys.php?prav_par=36): Numeral combining stems, including дев’яносто.
- [2019 Ukrainian Orthography, §38](https://slovnyk.ua/pravopys.php?prav_par=38&prav_swrd=1733): Joined and separate compound ordinal components.
- [2019 Ukrainian Orthography, §106](https://slovnyk.ua/pravopys.php?prav_par=106): Declension of compound ordinals.
- [Ukrainian Numeral Grammar](https://hramatyka.tpk-vnau.org/public_html/page44.html): Ordinal-compound stem rules.
- [Unicode CLDR: Ukrainian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/uk.xml): The spell-out rules ICU uses to write numbers in words.
