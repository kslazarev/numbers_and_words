# Armenian (`hy`)

Հայերեն. Scale words follow the short scale used in Armenia, from միլիարդ (10<sup>9</sup>) through տրիլիոն, կվադրիլիոն, կվինտիլիոն, սեքստիլիոն, սեպտիլիոն, օկտիլիոն, նոնիլիոն and դեցիլիոն (10<sup>33</sup>). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:hy) { 0.to_words }
# => "զրո"

I18n.with_locale(:hy) { 21.to_words }
# => "քսանմեկ"

I18n.with_locale(:hy) { 231.to_words }
# => "երկու հարյուր երեսունմեկ"

I18n.with_locale(:hy) { 4030.to_words }
# => "չորս հազար երեսուն"

I18n.with_locale(:hy) { 1_000_100.to_words }
# => "մեկ միլիոն հարյուր"

I18n.with_locale(:hy) { 2_000_000_000.to_words }
# => "երկու միլիարդ"

I18n.with_locale(:hy) { 1_000_000_000_000_000.to_words }
# => "մեկ կվադրիլիոն"

I18n.with_locale(:hy) { [1, 2, 3].to_words }
# => ["մեկ", "երկու", "երեք"]

I18n.with_locale(:hy) { [11, 22, 133].to_words }
# => ["տասնմեկ", "քսաներկու", "հարյուր երեսուներեք"]
```

## Decimals

Decimals are read with ստորակետ and then each fractional digit, including leading zeros, as Unicode CLDR reads them (CLDR spells the word ստորակել).

```ruby
I18n.with_locale(:hy) { 3.14.to_words }
# => "երեք ստորակետ մեկ չորս"

I18n.with_locale(:hy) { 21.05.to_words }
# => "քսանմեկ ստորակետ զրո հինգ"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:hy) { 0.1.to_words(precision: 2) }
# => "զրո ստորակետ մեկ զրո"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:hy) { 21.77.to_words(micro_separator: "կետ") }
# => "քսանմեկ կետ յոթ յոթ"
```

### Ordinal

`ordinal: true` gives առաջին to չորրորդ for 1 to 4, and otherwise adds -երորդ to the last word ("քսանմեկերորդ"), changing a final ը to ն first ("իններորդ", "տասներորդ"). Ordinals are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:hy) { 1.to_words(ordinal: true) }
# => "առաջին"

I18n.with_locale(:hy) { 21.to_words(ordinal: true) }
# => "քսանմեկերորդ"

I18n.with_locale(:hy) { 2_000.to_words(ordinal: true) }
# => "երկու հազարերորդ"

I18n.with_locale(:hy) { 1_000_000_000_000_000.to_words(ordinal: true) }
# => "կվադրիլիոներորդ"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps ստորակետ.

```ruby
I18n.with_locale(:hy) { 0.7.to_words(remove_zero: true) }
# => "ստորակետ յոթ"
```

## Sources

- [Omniglot: Armenian Numbers](https://www.omniglot.com/language/numbers/armenian.htm): Cardinal and ordinal forms, including final-vowel changes.
- [Wiktionary: Quadrillion](https://en.wiktionary.org/wiki/հազար_երկիլիոն): կվադրիլիոն and its ordinal կվադրիլիոներորդ.
- [Armenian Wikipedia: Number Naming Systems](https://hy.wikipedia.org/wiki/Թվերի_անվանման_համակարգեր): Short-scale names of large numbers, from կվինտիլիոն to դեցիլիոն.
- [Unicode CLDR: Armenian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/hy.xml): The spell-out rules ICU uses to write numbers in words.
