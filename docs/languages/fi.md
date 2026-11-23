# Finnish (`fi`)

Suomi. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers below a million are one word (kaksituhattakaksikymmentäyksi); millions and larger are separate words (kaksi miljoonaa). Scale words take the partitive after numbers above one (kaksituhatta, kaksi miljoonaa), and a lone one is omitted (tuhat, miljoona). Biljoona (10<sup>12</sup>), triljoona (10<sup>18</sup>), kvadriljoona (10<sup>24</sup>) and kvintiljoona (10<sup>30</sup>) count up to 999 999 times, so 10<sup>15</sup> is tuhat biljoonaa and 10<sup>21</sup> tuhat triljoonaa, the recommended readings, rather than the rare biljardi and triljardi. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`. Finnish numbers have no gender.

## Examples

```ruby
I18n.with_locale(:fi) { 0.to_words }
# => "nolla"

I18n.with_locale(:fi) { 21.to_words }
# => "kaksikymmentäyksi"

I18n.with_locale(:fi) { 231.to_words }
# => "kaksisataakolmekymmentäyksi"

I18n.with_locale(:fi) { 4030.to_words }
# => "neljätuhattakolmekymmentä"

I18n.with_locale(:fi) { 1_000_100.to_words }
# => "miljoona sata"

I18n.with_locale(:fi) { 2_000_000_000.to_words }
# => "kaksi miljardia"

I18n.with_locale(:fi) { [1, 2, 3].to_words }
# => ["yksi", "kaksi", "kolme"]

I18n.with_locale(:fi) { [11, 22, 133].to_words }
# => ["yksitoista", "kaksikymmentäkaksi", "satakolmekymmentäkolme"]
```

## Decimals

Decimals are read with pilkku and then each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:fi) { 3.14.to_words }
# => "kolme pilkku yksi neljä"

I18n.with_locale(:fi) { 21.05.to_words }
# => "kaksikymmentäyksi pilkku nolla viisi"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:fi) { 0.1.to_words(precision: 2) }
# => "nolla pilkku yksi nolla"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:fi) { 21.77.to_words(micro_separator: "piste") }
# => "kaksikymmentäyksi piste seitsemän seitsemän"
```

### Ordinal

`ordinal: true` makes every part ordinal, with ensimmäinen and toinen at the end and yhdes and kahdes inside a number (yhdestoista, kahdeskymmenesensimmäinen).

```ruby
I18n.with_locale(:fi) { 1.to_words(ordinal: true) }
# => "ensimmäinen"

I18n.with_locale(:fi) { 21.to_words(ordinal: true) }
# => "kahdeskymmenesensimmäinen"

I18n.with_locale(:fi) { 2000.to_words(ordinal: true) }
# => "kahdestuhannes"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps pilkku.

```ruby
I18n.with_locale(:fi) { 0.7.to_words(remove_zero: true) }
# => "pilkku seitsemän"
```

## Sources

- [Finnish Language Office: Ordinals](https://kielitoimistonohjepankki.fi/ohje/luvut-ja-numerot-jarjestysluvut/): Ordinal usage and spelling.
- [J. Korpela: Basic Finnish Numerals](https://www.jkorpela.fi/finnish/Basic_numerals.html): Cardinal and ordinal forms.
- [Wikipedia: Suurten lukujen nimet](https://fi.wikipedia.org/wiki/Suurten_lukujen_nimet): The names triljoona, kvadriljoona and kvintiljoona, and biljardi and triljardi as nonstandard.
- [Wiktionary: biljardi](https://en.wiktionary.org/wiki/biljardi): Tuhat biljoonaa as the recommended reading of 10<sup>15</sup>.
- [Unicode CLDR: Finnish Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/fi.xml): The spell-out rules ICU uses to write numbers in words.
