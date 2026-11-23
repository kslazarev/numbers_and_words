# Filipino (`fil`)

Filipino. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

The gem spells native Tagalog numbers, in everyday spelling without the dictionary accents Unicode CLDR writes (isa, not isá). Teens are labing- joined to the unit: assimilated before a consonant (labindalawa, labimpito) and hyphenated before a vowel and w (labing-isa, labing-walo). Tens are one word (dalawampu, tatlumpu, apatnapu). A count before daan (hundred), libo (thousand) and the larger scales takes the linker -ng, -g after n, or na after a consonant (dalawang daan, isang daang libo, apat na libo). Daan becomes raan after a vowel (apat na raan). ’t, short for at (and), follows tens and thousands (dalawampu’t isa, isang libo’t isa), and at follows hundreds and millions (isang daan at isa). Scales follow the short scale: milyon, bilyon (10<sup>9</sup>), trilyon and katrilyon (10<sup>15</sup>) as in Unicode CLDR, then kuwintilyon, sekstilyon, septilyon, oktilyon, nonilyon and desilyon (10<sup>33</sup>), which follow the same pattern and await a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

The Spanish-derived numbers (uno, dos, tres), which Filipino uses for time and money, and the forms sandaan and sanlibo aren't supported.

## Examples

```ruby
I18n.with_locale(:fil) { 0.to_words }
# => "wala"

I18n.with_locale(:fil) { 12.to_words }
# => "labindalawa"

I18n.with_locale(:fil) { 21.to_words }
# => "dalawampu’t isa"

I18n.with_locale(:fil) { 400.to_words }
# => "apat na raan"

I18n.with_locale(:fil) { 1_001.to_words }
# => "isang libo’t isa"

I18n.with_locale(:fil) { 100_000.to_words }
# => "isang daang libo"

I18n.with_locale(:fil) { 2_000_000.to_words }
# => "dalawang milyon"

I18n.with_locale(:fil) { [1, 2, 3].to_words }
# => ["isa", "dalawa", "tatlo"]
```

## Decimals

Decimals are read with tuldok followed by each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:fil) { 3.14.to_words }
# => "tatlo tuldok isa apat"

I18n.with_locale(:fil) { 21.05.to_words }
# => "dalawampu’t isa tuldok wala lima"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:fil) { 0.1.to_words(precision: 2) }
# => "wala tuldok isa wala"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:fil) { 21.77.to_words(micro_separator: "punto") }
# => "dalawampu’t isa punto pito pito"
```

### Ordinal

`ordinal: true` joins ika- to the cardinal (ikaapat, ikadalawampu’t isa), with una, ikalawa and ikatlo for one, two and three. A number of several words takes it on the first (ikaisang daan, not ikasandaan). Zero and decimals keep the cardinal form.

```ruby
I18n.with_locale(:fil) { 1.to_words(ordinal: true) }
# => "una"

I18n.with_locale(:fil) { 3.to_words(ordinal: true) }
# => "ikatlo"

I18n.with_locale(:fil) { 21.to_words(ordinal: true) }
# => "ikadalawampu’t isa"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps tuldok.

```ruby
I18n.with_locale(:fil) { 0.7.to_words(remove_zero: true) }
# => "tuldok pito"
```

## Sources

- [Wikipedia: Tagalog Grammar, Numbers](https://en.wikipedia.org/wiki/Tagalog_grammar#Numbers): Cardinal and ordinal numbers, linkers and the daan/raan alternation.
- [Komisyon sa Wikang Filipino: Ortograpiyang Pambansa](https://kwf.gov.ph/): The national orthography, without accents in everyday writing.
- [Unicode CLDR: Filipino Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/fil.xml): The spell-out rules ICU uses to write numbers in words.
