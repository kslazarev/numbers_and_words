# Latvian (`lv`)

Latviešu is the Latvian name of the language. A hundred is simts on its own and simt before another word (simt viens, simt tūkstoši). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:lv) { 0.to_words }
# => "nulle"

I18n.with_locale(:lv) { 21.to_words }
# => "divdesmit viens"

I18n.with_locale(:lv) { 231.to_words }
# => "divi simti trīsdesmit viens"

I18n.with_locale(:lv) { 4030.to_words }
# => "četri tūkstoši trīsdesmit"

I18n.with_locale(:lv) { 1_000_100.to_words }
# => "viens miljons simts"

I18n.with_locale(:lv) { 2_000_000_000.to_words }
# => "divi miljardi"

I18n.with_locale(:lv) { [1, 2, 3].to_words }
# => ["viens", "divi", "trīs"]

I18n.with_locale(:lv) { [11, 22, 133].to_words }
# => ["vienpadsmit", "divdesmit divi", "simt trīsdesmit trīs"]
```

## Decimals

Decimals are read with komats followed by each fractional digit, including leading zeros, as in Unicode CLDR.

```ruby
I18n.with_locale(:lv) { 3.14.to_words }
# => "trīs komats viens četri"

I18n.with_locale(:lv) { 21.05.to_words }
# => "divdesmit viens komats nulle pieci"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:lv) { 0.1.to_words(precision: 2) }
# => "nulle komats viens nulle"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:lv) { 21.77.to_words(micro_separator: 'punkts') }
# => "divdesmit viens punkts septiņi septiņi"
```

### Gender

The `gender: :male` (default) or `gender: :female` option sets the gender of the last group. The counts of tūkstotis and larger scale words stay masculine. Ordinals take the feminine ending.

```ruby
I18n.with_locale(:lv) { 1.to_words(gender: :female) }
# => "viena"

I18n.with_locale(:lv) { 22.to_words(gender: :female) }
# => "divdesmit divas"

I18n.with_locale(:lv) { 2_000_001.to_words(gender: :female) }
# => "divi miljoni viena"

I18n.with_locale(:lv) { 1.to_words(ordinal: true, gender: :female) }
# => "pirmā"

I18n.with_locale(:lv) { 3.to_words(ordinal: true, gender: :female) }
# => "trešā"
```

### Ordinal

The `ordinal: true` option makes the last word ordinal ("divdesmit pirmais"). A round hundred, thousand or larger scale is one word with a one-word multiplier in its combining form (divsimtais, piectūkstošais, desmittūkstošais, divmiljonais). A multiplier of several words stays separate (divdesmit viens tūkstošais). Ordinals are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:lv) { 1.to_words(ordinal: true) }
# => "pirmais"

I18n.with_locale(:lv) { 21.to_words(ordinal: true) }
# => "divdesmit pirmais"

I18n.with_locale(:lv) { 2_000.to_words(ordinal: true) }
# => "divtūkstošais"

I18n.with_locale(:lv) { 101.to_words(ordinal: true) }
# => "simt pirmais"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part and keeps komats.

```ruby
I18n.with_locale(:lv) { 0.7.to_words(remove_zero: true) }
# => "komats septiņi"
```

## Sources

- [Latvian National Encyclopedia: Numerals](https://enciklopedija.lv/skirklis/107482-skait%C4%BCa-v%C4%81rds): Cardinal and ordinal grammar.
- [Tēzaurs: triljons](https://tezaurs.lv/triljons): The large-scale number name.
- [Uzdevumi.lv: Numeral Spelling](https://www.uzdevumi.lv/p/latviesu-valoda-pec-skola2030-paraugprogrammas/6-klase/kadas-ir-teksta-pazimes-ka-pareizi-pierakstit-pamata-un-kartas-skaitla-va_-95709/skaitla-vardi-to-saskanojums-ar-lietvardu-un-pareizrakstiba-60391/re-7ca2f1c0-8b39-4dec-be38-8a0a6d99616b): Agreement and spelling examples.
- [Unicode CLDR: Latvian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/lv.xml): The spell-out rules ICU uses to write numbers in words.
