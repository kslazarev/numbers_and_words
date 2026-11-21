# Finnish (`fi`)

Suomi. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers below a million are written as one word (kaksituhattakaksikymmentäyksi), and millions and larger as separate words (kaksi miljoonaa). Scale words take the partitive after numbers above one (kaksituhatta, kaksi miljoonaa), and a lone one is omitted (tuhat, miljoona). Numbers up to 999,999,999,999,999 are supported, with miljoona, miljardi and biljoona; larger numbers raise `RangeError`. Finnish numbers have no grammatical gender.

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

Decimals are read with pilkku followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:fi) { 3.14.to_words }
# => "kolme pilkku yksi neljä"

I18n.with_locale(:fi) { 21.05.to_words }
# => "kaksikymmentäyksi pilkku nolla viisi"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

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
- [Unicode CLDR: Finnish Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/fi.xml): The spell-out rules ICU uses to write numbers in words.
