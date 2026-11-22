# Italian (`it`)

Italiano. Cento drops its final o before otto and ottanta (centotto, duecentottanta). Numbers up to 10<sup>48</sup> - 1 are supported; larger numbers raise `RangeError`.

Aliases: `it-CH`.

## Examples

```ruby
I18n.with_locale(:it) { 0.to_words }
# => "zero"

I18n.with_locale(:it) { 21.to_words }
# => "ventuno"

I18n.with_locale(:it) { 231.to_words }
# => "duecentotrentuno"

I18n.with_locale(:it) { 4030.to_words }
# => "quattromilatrenta"

I18n.with_locale(:it) { 1_000_100.to_words }
# => "un milione cento"

I18n.with_locale(:it) { 2_000_000_000.to_words }
# => "due miliardi"

I18n.with_locale(:it) { 1_001_000.to_words }
# => "un milione mille"

I18n.with_locale(:it) { [1, 2, 3].to_words }
# => ["uno", "due", "tre"]

I18n.with_locale(:it) { [11, 22, 133].to_words }
# => ["undici", "ventidue", "centotrentatré"]
```

## Decimals

Decimals are read as a fraction. [`fraction: false`](#fraction), the default in 2.0, reads them with `virgola`.

```ruby
I18n.with_locale(:it) { 21.77.to_words }
# => "ventuno e settantasette centesimi"

I18n.with_locale(:it) { 3.05.to_words }
# => "tre e cinque centesimi"

I18n.with_locale(:it) { 3.1416.to_words }
# => "tre e millequattrocentosedici decimillesimi"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:it) { 0.1.to_words(precision: 2) }
# => "zero e dieci centesimi"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:it) { 21.77.to_words(micro_separator: "plus") }
# => "ventuno plus settantasette centesimi"
```

### Fraction

`fraction: true`, the default, reads decimals as a fraction. `fraction: false` reads them with `virgola`: up to three decimal places as a number, after a `zero` for each leading zero, and longer ones digit by digit. It becomes the default in 2.0, and the gem warns about the change (see [UPGRADING](../../UPGRADING.md)).

```ruby
I18n.with_locale(:it) { 21.77.to_words(fraction: false) }
# => "ventuno virgola settantasette"

I18n.with_locale(:it) { 3.05.to_words(fraction: false) }
# => "tre virgola zero cinque"

I18n.with_locale(:it) { 3.1416.to_words(fraction: false) }
# => "tre virgola uno quattro uno sei"
```

### Ordinal

`ordinal: true` gives the masculine form. Above ten the ordinal is one word ending in -esimo ("ventunesimo", "duemillesimo"). Final tre and sei keep their vowel before the suffix ("ventitreesimo", "ventiseiesimo"). Zero keeps its cardinal form.

```ruby
I18n.with_locale(:it) { 1.to_words(ordinal: true) }
# => "primo"

I18n.with_locale(:it) { 21.to_words(ordinal: true) }
# => "ventunesimo"

I18n.with_locale(:it) { 2_000.to_words(ordinal: true) }
# => "duemillesimo"

I18n.with_locale(:it) { 180.to_words(ordinal: true) }
# => "centottantesimo"

I18n.with_locale(:it) { 3_000_003.to_words(ordinal: true) }
# => "tremilionitreesimo"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:it) { 0.7.to_words(remove_zero: true) }
# => "sette decimi"
```

## Sources

- [Treccani: Ordinal Numeral Adjectives](https://www.treccani.it/enciclopedia/aggettivi-numerali-ordinali_%28La-grammatica-italiana%29/): Ordinal suffixes and preservation of final vowels in tre and sei.
- [Treccani: Numeral Reference Guide](https://www.treccani.it/enciclopedia/numerali-prontuario_%28Enciclopedia-dell%27Italiano%29/): Cardinal and ordinal formation.
- [Unicode CLDR: Italian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/it.xml): The spell-out rules ICU uses to write numbers in words.
