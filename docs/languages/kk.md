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

Decimals are read as the whole part, бүтін, and the fractional part as a count of the fraction word in the ablative (оннан, жүзден, мыңнан), as Unicode CLDR reads them: 7.5 is five of ten. Up to 18 fractional digits are supported; more raise `RangeError`.

```ruby
I18n.with_locale(:kk) { 3.14.to_words }
# => "үш бүтін жүзден он төрт"

I18n.with_locale(:kk) { 21.05.to_words }
# => "жиырма бір бүтін жүзден бес"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:kk) { 0.1.to_words(precision: 2) }
# => "нөл бүтін жүзден он"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:kk) { 21.77.to_words(micro_separator: "нүкте") }
# => "жиырма бір нүкте жүзден жетпіс жеті"
```

### Ordinal

`ordinal: true` makes the last word ordinal by vowel harmony: -ыншы or -інші after consonants, -ншы or -нші after vowels ("екінші"). Some stems change ("қырық" becomes "қырқыншы"). Ordinals are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:kk) { 1.to_words(ordinal: true) }
# => "бірінші"

I18n.with_locale(:kk) { 21.to_words(ordinal: true) }
# => "жиырма бірінші"

I18n.with_locale(:kk) { 2_000.to_words(ordinal: true) }
# => "екі мыңыншы"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and бүтін.

```ruby
I18n.with_locale(:kk) { 0.7.to_words(remove_zero: true) }
# => "оннан жеті"
```

## Sources

- [Wiktionary: екі](https://en.wiktionary.org/wiki/екі#Kazakh): Ordinal suffixing after a final vowel.
- [Wiktionary: қырық](https://en.wiktionary.org/wiki/қырық#Kazakh): The exceptional ordinal stem in қырқыншы.
- [Unicode CLDR: Kazakh Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/kk.xml): The spell-out rules ICU uses to write numbers in words.
