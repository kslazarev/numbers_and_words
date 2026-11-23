# Esperanto (`eo`)

The language is also called Esperanto in Esperanto. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Tens and hundreds are single words formed from the units (dudek, ducent), and the other parts follow with spaces (dudek unu, cent dek du). Zero is the numeral nul, not the noun nulo. Mil and the scale nouns take their count before them and leave out unu (mil, du mil, miliono, du milionoj). The nouns take the plural -j after a count above one. Scales follow the long scale: miliono (10<sup>6</sup>), miliardo (10<sup>9</sup>), biliono (10<sup>12</sup>), triliono (10<sup>18</sup>), kvadriliono (10<sup>24</sup>) and kvintiliono (10<sup>30</sup>). The powers between them are a thousand of the word below (mil bilionoj for 10<sup>15</sup>): biliardo, triliardo and the other -iardo words don't exist in Esperanto, although Unicode CLDR uses biliardo. The names past triliono are rare and await a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:eo) { 0.to_words }
# => "nul"

I18n.with_locale(:eo) { 13.to_words }
# => "dek tri"

I18n.with_locale(:eo) { 21.to_words }
# => "dudek unu"

I18n.with_locale(:eo) { 245.to_words }
# => "ducent kvardek kvin"

I18n.with_locale(:eo) { 1_000.to_words }
# => "mil"

I18n.with_locale(:eo) { 2_021.to_words }
# => "du mil dudek unu"

I18n.with_locale(:eo) { 1_000_000.to_words }
# => "miliono"

I18n.with_locale(:eo) { 3_000_000_000.to_words }
# => "tri miliardoj"

I18n.with_locale(:eo) { 1_000_000_000_000_000.to_words }
# => "mil bilionoj"

I18n.with_locale(:eo) { [1, 2, 3].to_words }
# => ["unu", "du", "tri"]
```

## Decimals

Decimals are read with `komo` followed by each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:eo) { 3.14.to_words }
# => "tri komo unu kvar"

I18n.with_locale(:eo) { 21.05.to_words }
# => "dudek unu komo nul kvin"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:eo) { 0.1.to_words(precision: 2) }
# => "nul komo unu nul"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:eo) { 21.77.to_words(micro_separator: "punkto") }
# => "dudek unu punkto sep sep"
```

### Ordinal

The `ordinal: true` option adds the adjective ending -a and joins the words of a compound with hyphens (unua, dudek-unua, du-mila). A final scale noun changes its -o to -a (miliona), and one before a remainder keeps its form (miliono-unua). Unicode CLDR writes compound ordinals with spaces (dudek unua) and adds -a to the noun (milionoa). Ordinals are spelled up to the largest cardinal.

```ruby
I18n.with_locale(:eo) { 1.to_words(ordinal: true) }
# => "unua"

I18n.with_locale(:eo) { 21.to_words(ordinal: true) }
# => "dudek-unua"

I18n.with_locale(:eo) { 2_000.to_words(ordinal: true) }
# => "du-mila"

I18n.with_locale(:eo) { 1_000_000.to_words(ordinal: true) }
# => "miliona"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part and keeps komo.

```ruby
I18n.with_locale(:eo) { 0.7.to_words(remove_zero: true) }
# => "komo sep"
```

## Sources

- [Plena Manlibro de Esperanta Gramatiko: Nombraj Vortetoj](https://bertilow.com/pmeg/gramatiko/nombroj/vortetoj/formoj.html): The numerals, from nul to mil.
- [Plena Manlibro de Esperanta Gramatiko: O-vortaj Nombrovortoj](https://bertilow.com/pmeg/gramatiko/nombroj/o-vortoj.html): Miliono, miliardo, biliono and the larger scale nouns, and why biliardo doesn't exist.
- [Plena Manlibro de Esperanta Gramatiko: A-vortaj Nombrovortoj](https://bertilow.com/pmeg/gramatiko/nombroj/a-vortoj.html): Ordinals, hyphenated in compounds (kvindek-unua), and miliona.
- [Unicode CLDR: Esperanto Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/eo.xml): The spell-out rules ICU uses to write numbers in words.
