# Latvian (`lv`)

Latviešu. A hundred is simts on its own and simt before another word (simt viens, simt tūkstoši). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

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

Ordinary decimal readings are not supported yet. A float without `unit` and `subunit`, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("Decimals are not supported in :lv."). Amounts with both [`unit` and `subunit`](../../README.md#unit) work.

## Options

### Precision

With `unit` and `subunit`, `precision` sets how many decimal places make one subunit (2 by default). It does not enable decimal readings.

### Micro Separator

`micro_separator` applies only to decimal readings, which are not supported, not to the separator between a unit and its subunit.

### Ordinal

`ordinal: true` makes the last word ordinal ("divdesmit pirmais"). A round hundred, thousand or larger scale is one word with the combining form of a one-word multiplier (divsimtais, piectūkstošais, desmittūkstošais, divmiljonais); a multiplier of several words stays separate (divdesmit viens tūkstošais). Ordinals are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

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

## Sources

- [Latvian National Encyclopedia: Numerals](https://enciklopedija.lv/skirklis/107482-skait%C4%BCa-v%C4%81rds): Cardinal and ordinal grammar.
- [Tēzaurs: triljons](https://tezaurs.lv/triljons): The large-scale number name.
- [Uzdevumi.lv: Numeral Spelling](https://www.uzdevumi.lv/p/latviesu-valoda-pec-skola2030-paraugprogrammas/6-klase/kadas-ir-teksta-pazimes-ka-pareizi-pierakstit-pamata-un-kartas-skaitla-va_-95709/skaitla-vardi-to-saskanojums-ar-lietvardu-un-pareizrakstiba-60391/re-7ca2f1c0-8b39-4dec-be38-8a0a6d99616b): Agreement and spelling examples.
- [Unicode CLDR: Latvian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/lv.xml): The spell-out rules ICU uses to write numbers in words.
