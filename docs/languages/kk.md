# Kazakh (`kk`)

Қазақша. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:kk) { 0.to_words }
# => "нөл"

I18n.with_locale(:kk) { 21.to_words }
# => "жиырма бір"

I18n.with_locale(:kk) { 231.to_words }
# => "екі жүз отыз бір"

I18n.with_locale(:kk) { 4030.to_words }
# => "төрт мың отыз"

I18n.with_locale(:kk) { 1_000_100.to_words }
# => "бір миллион жүз"

I18n.with_locale(:kk) { 2_000_000_000.to_words }
# => "екі миллиард"

I18n.with_locale(:kk) { [1, 2, 3].to_words }
# => ["бір", "екі", "үш"]

I18n.with_locale(:kk) { [11, 22, 133].to_words }
# => ["он бір", "жиырма екі", "жүз отыз үш"]
```

## Decimals

Ordinary decimal readings are not supported yet. Converting a float without `unit` and `subunit`, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("Decimals are not supported in :kk."). Amounts with both [`unit` and `subunit`](../../README.md#unit) are supported.

## Options

### Precision

With `unit` and `subunit`, `precision` sets how many decimal places make one subunit (2 by default). It does not enable ordinary decimal readings.

### Micro Separator

`micro_separator` applies to ordinary decimal readings, which are not supported yet. It does not change the separator between a unit and its subunit.

### Ordinal

`ordinal: true` makes the last word ordinal, following vowel harmony with -ыншы or -інші after consonants and -ншы or -нші after vowels ("екінші"). Some stems change ("қырық" becomes "қырқыншы"). Ordinals in this language are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:kk) { 1.to_words(ordinal: true) }
# => "бірінші"

I18n.with_locale(:kk) { 21.to_words(ordinal: true) }
# => "жиырма бірінші"

I18n.with_locale(:kk) { 2_000.to_words(ordinal: true) }
# => "екі мыңыншы"
```

## Sources

- [Wiktionary: екі](https://en.wiktionary.org/wiki/екі#Kazakh): Ordinal suffixing after a final vowel.
- [Wiktionary: қырық](https://en.wiktionary.org/wiki/қырық#Kazakh): The exceptional ordinal stem in қырқыншы.
- [Unicode CLDR: Kazakh Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/kk.xml): The spell-out rules ICU uses to write numbers in words.
