# Czech (`cs`)

Čeština is the Czech name of the language. Without [`gender`](#gender), numbers use the counting forms jedna and dva (jedna, dva, tři, dvacet dva). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:cs) { 0.to_words }
# => "nula"

I18n.with_locale(:cs) { 21.to_words }
# => "dvacet jedna"

I18n.with_locale(:cs) { 231.to_words }
# => "dvě stě třicet jedna"

I18n.with_locale(:cs) { 4030.to_words }
# => "čtyři tisíce třicet"

I18n.with_locale(:cs) { 1_000_100.to_words }
# => "jeden milion sto"

I18n.with_locale(:cs) { 2_000_000_000.to_words }
# => "dvě miliardy"

I18n.with_locale(:cs) { [1, 2, 3].to_words }
# => ["jedna", "dva", "tři"]

I18n.with_locale(:cs) { [11, 22, 133].to_words }
# => ["jedenáct", "dvacet dva", "sto třicet tři"]
```

## Decimals

Fraction names are unaccented like the scale words (biliontina, biliontiny and biliontin, as bilion). Accented variants are also valid Czech.

```ruby
I18n.with_locale(:cs) { 21.77.to_words }
# => "dvacet jedna celých sedmdesát sedm setin"

I18n.with_locale(:cs) { 0.000000000001.to_words(precision: 12) }
# => "nula celá jedna biliontina"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:cs) { 0.1.to_words(precision: 2) }
# => "nula celá deset setin"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:cs) { 21.77.to_words(micro_separator: 'plus') }
# => "dvacet jedna celých plus sedmdesát sedm setin"
```

### Gender

The `gender` option takes `:female`, `:male` or `:neuter`. Without it, numbers use the counting forms (jedna, dva) and ordinals the feminine.

```ruby
I18n.with_locale(:cs) { 1.to_words(gender: :female) }
# => "jedna"

I18n.with_locale(:cs) { 1.to_words(gender: :male) }
# => "jeden"

I18n.with_locale(:cs) { 1.to_words(gender: :neuter) }
# => "jedno"

I18n.with_locale(:cs) { 22.to_words }
# => "dvacet dva"

I18n.with_locale(:cs) { 22.to_words(gender: :female) }
# => "dvacet dvě"
```

### Ordinal

The `ordinal: true` option, optionally with gender, makes every part ordinal ("tisící dvoustý třicátý čtvrtý"). The count of a thousand or a larger scale word joins its ordinal in the genitive combining form ("desetitisící", "dvacetijednatisící", "stotisící", "dvoumiliontý"), leaving out a count of one ("miliontý").

```ruby
I18n.with_locale(:cs) { 21.to_words(ordinal: true) }
# => "dvacátá první"

I18n.with_locale(:cs) { 21.to_words(gender: :female, ordinal: true) }
# => "dvacátá první"

I18n.with_locale(:cs) { 12_345.to_words(gender: :male, ordinal: true) }
# => "dvanáctitisící třístý čtyřicátý pátý"

I18n.with_locale(:cs) { 2_000_000.to_words(gender: :male, ordinal: true) }
# => "dvoumiliontý"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part.

```ruby
I18n.with_locale(:cs) { 0.7.to_words(remove_zero: true) }
# => "sedm desetin"
```

## Sources

- [Czech Language Institute: Numeral Agreement](https://prirucka.ujc.cas.cz/?id=791#nadpis3): Agreement when reading decimal numbers.
- [Czech Language Institute: bilion](https://prirucka.ujc.cas.cz/?slovo=bilion): Accented and unaccented scale-word variants.
- [Czech Language Institute: miliontina](https://prirucka.ujc.cas.cz/?slovo=miliontina): Corresponding spelling variants in fraction names.
- [Biliontina](https://cs.wikipedia.org/wiki/Biliontina): The fraction name for one trillionth.
- [Czech Language Institute: kvintilion](https://prirucka.ujc.cas.cz/?slovo=kvintilion): The forms of kvintilion.
- [Unicode CLDR: Czech Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/cs.xml): The spell-out rules ICU uses to write numbers in words.
