# Afrikaans (`af`)

The language is also called Afrikaans in Afrikaans. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

The ones come before the tens, joined by -en- (een-en-twintig, nege-en-negentig). Honderd and duisend leave out a count of one and are joined to their count (honderd, tweehonderd, tweeduisend, tienduisend). As in Unicode CLDR, duisend is written apart after a count from 21 (een-en-twintig duisend, honderd duisend). Miljoen and the larger scale words keep een and are written apart (een miljoen, twee miljoen). Scales follow the long scale, from miljoen (10<sup>6</sup>) and miljard (10<sup>9</sup>) through biljoen, biljard, triljoen, triljard, kwadriljoen, kwadriljard, kwintiljoen and kwintiljard (10<sup>33</sup>). Unicode CLDR stops at biljard (10<sup>15</sup>), so the larger names follow the same pattern and await a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:af) { 0.to_words }
# => "nul"

I18n.with_locale(:af) { 13.to_words }
# => "dertien"

I18n.with_locale(:af) { 21.to_words }
# => "een-en-twintig"

I18n.with_locale(:af) { 245.to_words }
# => "tweehonderd vyf-en-veertig"

I18n.with_locale(:af) { 2_021.to_words }
# => "tweeduisend een-en-twintig"

I18n.with_locale(:af) { 21_000.to_words }
# => "een-en-twintig duisend"

I18n.with_locale(:af) { 1_000_000.to_words }
# => "een miljoen"

I18n.with_locale(:af) { 3_000_000_000.to_words }
# => "drie miljard"

I18n.with_locale(:af) { [1, 2, 3].to_words }
# => ["een", "twee", "drie"]
```

## Decimals

Decimals are read with `komma` followed by each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:af) { 3.14.to_words }
# => "drie komma een vier"

I18n.with_locale(:af) { 21.05.to_words }
# => "een-en-twintig komma nul vyf"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:af) { 0.1.to_words(precision: 2) }
# => "nul komma een nul"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:af) { 21.77.to_words(micro_separator: "punt") }
# => "een-en-twintig punt sewe sewe"
```

### Ordinal

The `ordinal: true` option makes the last word ordinal, with -de up to negentiende and -ste from twintigste (eerste, tweede, derde, sewende, agtste, een-en-twintigste, honderdste). A final one after honderd, duisend or a scale word is en eerste (honderd en eerste, duisend en eerste). Unicode CLDR differs: it writes een before honderd and duisend in ordinals (een duisendste), sewede, agtde and negede, and honderd eenste for 101st. The gem follows its own cardinals and the Afrikaanse Woordelys en Spelreëls instead. Ordinals are spelled up to the largest cardinal.

```ruby
I18n.with_locale(:af) { 1.to_words(ordinal: true) }
# => "eerste"

I18n.with_locale(:af) { 8.to_words(ordinal: true) }
# => "agtste"

I18n.with_locale(:af) { 21.to_words(ordinal: true) }
# => "een-en-twintigste"

I18n.with_locale(:af) { 101.to_words(ordinal: true) }
# => "honderd en eerste"

I18n.with_locale(:af) { 2_000_000.to_words(ordinal: true) }
# => "twee miljoenste"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part and keeps komma.

```ruby
I18n.with_locale(:af) { 0.7.to_words(remove_zero: true) }
# => "komma sewe"
```

## Sources

- [Wikipedia: Afrikaanse Woordelys en Spelreëls](https://en.wikipedia.org/wiki/Afrikaanse_Woordelys_en_Spelre%C3%ABls): The Afrikaans spelling standard.
- [Elon.io: Writing Numbers in Afrikaans](https://elon.io/grammar/afrikaans/numbers/writing-numbers): Hyphenated een-en-twintig, ordinals in -de and -ste, and komma.
- [Unicode CLDR: Afrikaans Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/af.xml): The spell-out rules ICU uses to write numbers in words.
