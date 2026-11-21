# Azerbaijani (`az`)

Azərbaycan dili, in the Latin alphabet. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Azerbaijani counts like Turkish: one hundred and one thousand are "yüz" and "min" alone, and larger scales keep "bir" (bir milyon). The scale words are milyon, milyard, trilyon, kvadrilyon and so on, in the short scale. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:az) { 0.to_words }
# => "sıfır"

I18n.with_locale(:az) { 21.to_words }
# => "iyirmi bir"

I18n.with_locale(:az) { 80.to_words }
# => "səksən"

I18n.with_locale(:az) { 231.to_words }
# => "iki yüz otuz bir"

I18n.with_locale(:az) { 1_001.to_words }
# => "min bir"

I18n.with_locale(:az) { 21_000.to_words }
# => "iyirmi bir min"

I18n.with_locale(:az) { 1_000_000.to_words }
# => "bir milyon"

I18n.with_locale(:az) { 2_000_000_000.to_words }
# => "iki milyard"

I18n.with_locale(:az) { [1, 2, 3].to_words }
# => ["bir", "iki", "üç"]
```

## Decimals

Decimals are read as fractions, the standard reading taught in Azerbaijani schools: the integral part, "tam" (whole), then the denominator in the locative case followed by the numerator, so 3.14 is "üç tam yüzdə on dörd", three wholes and fourteen in a hundred.

```ruby
I18n.with_locale(:az) { 0.5.to_words }
# => "sıfır tam onda beş"

I18n.with_locale(:az) { 3.14.to_words }
# => "üç tam yüzdə on dörd"

I18n.with_locale(:az) { 21.05.to_words }
# => "iyirmi bir tam yüzdə beş"

I18n.with_locale(:az) { 0.0001.to_words }
# => "sıfır tam on mində bir"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits, which changes the denominator.

```ruby
I18n.with_locale(:az) { 0.1.to_words(precision: 2) }
# => "sıfır tam yüzdə on"
```

### Micro Separator

`micro_separator` replaces "tam" between the integral and fractional parts.

```ruby
I18n.with_locale(:az) { 21.77.to_words(micro_separator: "vergül") }
# => "iyirmi bir vergül yüzdə yetmiş yeddi"
```

### Ordinal

`ordinal: true` adds -inci to the last word, following vowel harmony (-ıncı, -inci, -uncu, -üncü) and dropping its first vowel after a vowel ("ikinci", "altıncı"). One hundred, thousand or million drops "bir" ("milyonuncu").

```ruby
I18n.with_locale(:az) { 1.to_words(ordinal: true) }
# => "birinci"

I18n.with_locale(:az) { 21.to_words(ordinal: true) }
# => "iyirmi birinci"

I18n.with_locale(:az) { 40.to_words(ordinal: true) }
# => "qırxıncı"

I18n.with_locale(:az) { 2_000.to_words(ordinal: true) }
# => "iki mininci"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and "tam".

```ruby
I18n.with_locale(:az) { 0.7.to_words(remove_zero: true) }
# => "onda yeddi"
```

## Sources

- [Wiktionary: Azerbaijani Cardinal Numbers](https://en.wiktionary.org/wiki/Category:Azerbaijani_cardinal_numbers): Cardinal spellings.
- [Wiktionary: -inci](https://en.wiktionary.org/wiki/-inci#Azerbaijani): Ordinal suffixes and vowel harmony.
- [Unicode CLDR: Azerbaijani Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/az.xml): The spell-out rules ICU uses to write numbers in words.
