# Slovak (`sk`)

Slovenčina is the Slovak name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers below a million are written as one word (dvetisícdvestotridsaťštyri), and millions and larger as separate words (dva milióny tristotisíc). Scale words take the singular after one, which is left out (tisíc, milión). They take the nominative plural after two to four (dva milióny), and the genitive plural otherwise, also after compounds (päť miliónov, dvadsaťjeden miliónov). Tisíc and the scale words in -arda take dve (dvetisíc, dve miliardy, dve triliardy). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:sk) { 0.to_words }
# => "nula"

I18n.with_locale(:sk) { 21.to_words }
# => "dvadsaťjeden"

I18n.with_locale(:sk) { 231.to_words }
# => "dvestotridsaťjeden"

I18n.with_locale(:sk) { 4030.to_words }
# => "štyritisíctridsať"

I18n.with_locale(:sk) { 1_000_100.to_words }
# => "milión sto"

I18n.with_locale(:sk) { 5_000_000.to_words }
# => "päť miliónov"

I18n.with_locale(:sk) { 2_000_000_000.to_words }
# => "dve miliardy"

I18n.with_locale(:sk) { [1, 2, 3].to_words }
# => ["jeden", "dva", "tri"]

I18n.with_locale(:sk) { [11, 22, 133].to_words }
# => ["jedenásť", "dvadsaťdva", "stotridsaťtri"]
```

## Decimals

Decimals are read as a feminine whole number with celá, celé or celých, followed by a feminine number of desatiny, stotiny or tisíciny. Up to nine fractional digits are supported; more raise `RangeError`.

```ruby
I18n.with_locale(:sk) { 1.5.to_words }
# => "jedna celá päť desatín"

I18n.with_locale(:sk) { 21.77.to_words }
# => "dvadsaťjedna celých sedemdesiatsedem stotín"

I18n.with_locale(:sk) { 3.14.to_words }
# => "tri celé štrnásť stotín"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:sk) { 0.1.to_words(precision: 2) }
# => "nula celých desať stotín"
```

### Micro Separator

The `micro_separator` option adds a word between the integral and fractional parts.

```ruby
I18n.with_locale(:sk) { 21.77.to_words(micro_separator: "a") }
# => "dvadsaťjedna celých a sedemdesiatsedem stotín"
```

### Gender

The `gender: :male` (default), `:female` or `:neuter` option changes one and two at the end of the number (jeden, jedna, jedno; dva, dve), also in compounds (dvadsaťjedna).

```ruby
I18n.with_locale(:sk) { 1.to_words(gender: :male) }
# => "jeden"

I18n.with_locale(:sk) { 1.to_words(gender: :female) }
# => "jedna"

I18n.with_locale(:sk) { 22.to_words(gender: :neuter) }
# => "dvadsaťdve"
```

### Ordinal

The `ordinal: true` option makes the tens and ones ordinal (stodvadsiaty prvý), or a round hundred or scale with its multiplier (dvojstý, dvojtisíci, päťmiliónty), in the requested gender.

```ruby
I18n.with_locale(:sk) { 21.to_words(ordinal: true) }
# => "dvadsiaty prvý"

I18n.with_locale(:sk) { 21.to_words(ordinal: true, gender: :female) }
# => "dvadsiata prvá"

I18n.with_locale(:sk) { 2000.to_words(ordinal: true) }
# => "dvojtisíci"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part.

```ruby
I18n.with_locale(:sk) { 0.7.to_words(remove_zero: true) }
# => "sedem desatín"
```

## Sources

- [Short Dictionary of the Slovak Language: nula](https://slovnik.aktuality.sk/pravopis/kratky-slovnik/?q=nula): The decimal reading nula celých.
- [Wikipedia: Kvadrilión](https://sk.wikipedia.org/wiki/Kvadrili%C3%B3n): Scale names from triliarda (10<sup>21</sup>) to kvintiliarda (10<sup>33</sup>).
- [Unicode CLDR: Slovak Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/sk.xml): The spell-out rules ICU uses to write numbers in words.
