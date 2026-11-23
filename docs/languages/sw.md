# Swahili (`sw`)

Kiswahili. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

The count follows mia (hundred) and the scale words (mia mbili, elfu tatu, milioni ishirini na moja), and na (and) joins every part (mia moja na ishirini na moja). Unicode CLDR joins the groups after a thousand or a million with a comma (elfu moja, mia moja); the gem uses na there too (elfu moja na mia moja), as grammars also give. A hundred thousand is elfu mia moja, as in CLDR, not laki moja. Scales follow the short scale: milioni, bilioni (10<sup>9</sup>), trilioni and kvadrilioni (10<sup>15</sup>) as in CLDR, then kwintilioni, sekstilioni, septilioni, oktilioni, nonilioni and desilioni (10<sup>33</sup>), extended by the same pattern for a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Numbers spelled out are the counting forms; the noun-class agreement of one to five and eight with a counted noun (watu wawili, vitu viwili) isn't supported.

## Examples

```ruby
I18n.with_locale(:sw) { 0.to_words }
# => "sifuri"

I18n.with_locale(:sw) { 21.to_words }
# => "ishirini na moja"

I18n.with_locale(:sw) { 121.to_words }
# => "mia moja na ishirini na moja"

I18n.with_locale(:sw) { 2_021.to_words }
# => "elfu mbili na ishirini na moja"

I18n.with_locale(:sw) { 21_000.to_words }
# => "elfu ishirini na moja"

I18n.with_locale(:sw) { 2_000_000.to_words }
# => "milioni mbili"

I18n.with_locale(:sw) { [1, 2, 3].to_words }
# => ["moja", "mbili", "tatu"]
```

## Decimals

Decimals are read with nukta followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:sw) { 3.14.to_words }
# => "tatu nukta moja nne"

I18n.with_locale(:sw) { 21.05.to_words }
# => "ishirini na moja nukta sifuri tano"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:sw) { 0.1.to_words(precision: 2) }
# => "sifuri nukta moja sifuri"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:sw) { 21.77.to_words(micro_separator: "pointi") }
# => "ishirini na moja pointi saba saba"
```

### Ordinal

`ordinal: true` gives wa and the cardinal (wa tatu, wa ishirini na moja), with kwanza and pili for one and two (wa kwanza, wa pili). Wa is the concord of the first noun class (mtu wa tatu); other classes (ya, la, cha, za) aren't supported. CLDR omits wa for the first and second only. Decimals keep the cardinal form.

```ruby
I18n.with_locale(:sw) { 1.to_words(ordinal: true) }
# => "wa kwanza"

I18n.with_locale(:sw) { 2.to_words(ordinal: true) }
# => "wa pili"

I18n.with_locale(:sw) { 21.to_words(ordinal: true) }
# => "wa ishirini na moja"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps nukta.

```ruby
I18n.with_locale(:sw) { 0.7.to_words(remove_zero: true) }
# => "nukta saba"
```

## Sources

- [Wiktionary: Swahili Numbers](https://en.wiktionary.org/wiki/Appendix:Swahili_numbers): Cardinal and ordinal numbers.
- [O. Almasi et al.: Swahili Grammar for Introductory and Intermediate Level](https://hist.hse.ru/data/2019/06/14/1486230389/O.%20Almasi%20et%20al.%20-%20Swahili%20Grammar%20for%20Introductory%20and%20%20Intermediate%20Level.pdf): Numbers and their joining with na.
- [Unicode CLDR: Swahili Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/sw.xml): The spell-out rules ICU uses to write numbers in words.
