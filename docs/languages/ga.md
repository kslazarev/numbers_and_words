# Irish (`ga`)

Gaeilge. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers are bare numbers, the form used for counting, as in Unicode CLDR. The particle a comes before a final unit ("a haon", "fiche a haon"), and a comma follows a scale word ("míle, a haon"). The counts of scale words use the cardinal forms, and the count's last digit mutates the scale word: aon, dhá and trí to sé lenite it ("dhá mhíle", "trí mhilliún"), and seacht to deich eclipse it ("seacht gcéad", "ocht mbilliún"). Déag follows the scale word ("aon mhíle dhéag"), and the tens leave it unchanged ("fiche míle", "fiche is aon mhíle"). Irish uses the short scale: milliún, billiún, trilliún, quadrilliún. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Unicode CLDR stops at quadrilliún (10<sup>15</sup>). Quintilliún, sextilliún, septilliún, octilliún, nonilliún and deicilliún (10<sup>18</sup> to 10<sup>33</sup>) follow its pattern. They and their mutations (dhá shextilliún, ocht n-octilliún, trí dheicilliún) need a native speaker's review. Irish forms such as cuintilliún and seisilliún have also been proposed, but none is standard.

Numbers don't agree in gender. The forms used before a noun (aon, dhá, ceithre) appear only in the counts of scale words.

## Examples

```ruby
I18n.with_locale(:ga) { 0.to_words }
# => "a náid"

I18n.with_locale(:ga) { 12.to_words }
# => "a dó dhéag"

I18n.with_locale(:ga) { 21.to_words }
# => "fiche a haon"

I18n.with_locale(:ga) { 700.to_words }
# => "seacht gcéad"

I18n.with_locale(:ga) { 2_915.to_words }
# => "dhá mhíle, naoi gcéad a cúig déag"

I18n.with_locale(:ga) { 11_000.to_words }
# => "aon mhíle dhéag"

I18n.with_locale(:ga) { 123_456.to_words }
# => "céad fiche is trí mhíle, ceithre chéad caoga a sé"

I18n.with_locale(:ga) { 8_000_000_000.to_words }
# => "ocht mbilliún"

I18n.with_locale(:ga) { [1, 2, 3].to_words }
# => ["a haon", "a dó", "a trí"]
```

## Decimals

Decimals are read with pointe followed by each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:ga) { 3.14.to_words }
# => "a trí pointe a haon a ceathair"

I18n.with_locale(:ga) { 21.05.to_words }
# => "fiche a haon pointe a náid a cúig"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:ga) { 1.5.to_words(precision: 3) }
# => "a haon pointe a cúig a náid a náid"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:ga) { 21.77.to_words(micro_separator: "ponc") }
# => "fiche a haon ponc a seacht a seacht"
```

### Ordinal

`ordinal: true` follows the established system of An Caighdeán Oifigiúil, without the article an. Below a hundred, the ordinal of the last digit comes before the tens ("aonú is fiche"); above a hundred, it comes after them ("céad tríocha is aonú"). Aonú replaces céad in compounds, and déag isn't lenited. Second is dara, also in compounds; dóú is also standard. A round scale ordinal mutates like the cardinal ("dhá mhíliú"). Ordinals start at 1, as Irish has no ordinal of zero. Unicode CLDR has no Irish ordinals.

```ruby
I18n.with_locale(:ga) { 1.to_words(ordinal: true) }
# => "céad"

I18n.with_locale(:ga) { 12.to_words(ordinal: true) }
# => "dara déag"

I18n.with_locale(:ga) { 21.to_words(ordinal: true) }
# => "aonú is fiche"

I18n.with_locale(:ga) { 131.to_words(ordinal: true) }
# => "céad tríocha is aonú"

I18n.with_locale(:ga) { 1_007.to_words(ordinal: true) }
# => "míle is seachtú"

I18n.with_locale(:ga) { 2_000.to_words(ordinal: true) }
# => "dhá mhíliú"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps pointe.

```ruby
I18n.with_locale(:ga) { 0.7.to_words(remove_zero: true) }
# => "pointe a seacht"
```

## Sources

- [Gramadach na Gaeilge: An Caighdeán Oifigiúil, Chapter 9](https://calculuswhiz.github.io/caighdean-i18n/entrypoints/en_US/chapter9.html): Bare and cardinal numbers, mutations after numbers, and ordinals, in an English translation of the official standard.
- [Irish Language Forum: Large Numbers](https://www.irishlanguageforum.com/viewtopic.php?p=54111): Proposed Irish names past billiún, none of them standard.
- [Unicode CLDR: Irish Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/ga.xml): The spell-out rules ICU uses to write numbers in words.
- [Unicode CLDR: Plural Rules](https://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html): The one, two, few, many and other categories, which match the mutations after a number.
