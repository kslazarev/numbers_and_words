# French (`fr`)

Français. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Aliases: `fr-CA`.

## Examples

```ruby
I18n.with_locale(:fr) { 0.to_words }
# => "zéro"

I18n.with_locale(:fr) { 21.to_words }
# => "vingt et un"

I18n.with_locale(:fr) { 231.to_words }
# => "deux cent trente et un"

I18n.with_locale(:fr) { 4030.to_words }
# => "quatre mille trente"

I18n.with_locale(:fr) { 1_000_100.to_words }
# => "un million cent"

I18n.with_locale(:fr) { 2_000_000_000.to_words }
# => "deux milliards"

I18n.with_locale(:fr) { [1, 2, 3].to_words }
# => ["un", "deux", "trois"]

I18n.with_locale(:fr) { [11, 22, 133].to_words }
# => ["onze", "vingt-deux", "cent trente-trois"]
```

## Decimals

Decimals are read as a fraction joined with `et`. [`fraction: false`](#fraction), the default in 2.0, reads them with `virgule`.

```ruby
I18n.with_locale(:fr) { 21.77.to_words }
# => "vingt et un et soixante-dix-sept centièmes"

I18n.with_locale(:fr) { 3.05.to_words }
# => "trois et cinq centièmes"

I18n.with_locale(:fr) { 3.1416.to_words }
# => "trois et mille quatre cent seize dix-millièmes"
```

## Options

### Unit

With `one` and `other` unit translations, such as `units.euro.one: euro` and `units.euro.other: euros`, zero and decimals below two take the singular. A `zero` unit translation takes precedence.

```ruby
I18n.with_locale(:fr) { 0.to_words(unit: :euro) }
# => "zéro euro"
```

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:fr) { 0.1.to_words(precision: 2) }
# => "zéro et dix centièmes"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:fr) { 21.77.to_words(micro_separator: "plus") }
# => "vingt et un plus soixante-dix-sept centièmes"
```

### Fraction

`fraction: true`, the default, reads decimals as a fraction. `fraction: false` reads them with `virgule`: up to three decimal places as a number, after a `zéro` for each leading zero, and longer ones digit by digit. It becomes the default in 2.0, and the gem warns about the change (see [UPGRADING](../../UPGRADING.md)).

```ruby
I18n.with_locale(:fr) { 21.77.to_words(fraction: false) }
# => "vingt et un virgule soixante-dix-sept"

I18n.with_locale(:fr) { 3.05.to_words(fraction: false) }
# => "trois virgule zéro cinq"

I18n.with_locale(:fr) { 3.1416.to_words(fraction: false) }
# => "trois virgule un quatre un six"
```

### Gender

`gender: :male` (default) or `gender: :female`: a final un is une ("vingt et une"); the counts of mille and larger scale words stay masculine. A lone premier is première.

```ruby
I18n.with_locale(:fr) { 1.to_words(gender: :female) }
# => "une"

I18n.with_locale(:fr) { 21.to_words(gender: :female) }
# => "vingt et une"

I18n.with_locale(:fr) { 21_001.to_words(gender: :female) }
# => "vingt et un mille une"

I18n.with_locale(:fr) { 1.to_words(ordinal: true, gender: :female) }
# => "première"

I18n.with_locale(:fr) { 21.to_words(ordinal: true, gender: :female) }
# => "vingt et unième"
```

### Ordinal

`ordinal: true` gives the masculine form: 1 alone is premier, and otherwise only the last word takes the suffix -ième, dropping a final e or plural s ("deux centième"). The ordinal of a round million or larger is a numeral, so `spelling: :reformed` joins it to its multiplier with a hyphen ("deux-millionième"; traditional "deux millionième"). Decimals keep the cardinal form.

```ruby
I18n.with_locale(:fr) { 1.to_words(ordinal: true) }
# => "premier"

I18n.with_locale(:fr) { 21.to_words(ordinal: true) }
# => "vingt et unième"

I18n.with_locale(:fr) { 80.to_words(ordinal: true) }
# => "quatre-vingtième"

I18n.with_locale(:fr) { 200.to_words(ordinal: true) }
# => "deux centième"

I18n.with_locale(:fr) { 2_000_000.to_words(ordinal: true) }
# => "deux millionième"

I18n.with_locale(:fr) { 2_000_000.to_words(ordinal: true, spelling: :reformed) }
# => "deux-millionième"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:fr) { 0.7.to_words(remove_zero: true) }
# => "sept dixièmes"
```

### Spelling

`spelling: :traditional`, the default, puts spaces rather than hyphens around `et`, `cent` and `mille`. `spelling: :reformed` follows the 1990 reform, hyphenating every numeral in a compound number except the nouns million, milliard and larger. It becomes the default in 2.0, and the gem warns about the change (see [UPGRADING](../../UPGRADING.md)).

```ruby
I18n.with_locale(:fr) { 321.to_words }
# => "trois cent vingt et un"

I18n.with_locale(:fr) { 2_000_021.to_words }
# => "deux millions vingt et un"

I18n.with_locale(:fr) { 280_000_000.to_words }
# => "deux cent quatre-vingts millions"

I18n.with_locale(:fr) { 321.to_words(spelling: :reformed) }
# => "trois-cent-vingt-et-un"

I18n.with_locale(:fr) { 2_000_021.to_words(spelling: :reformed) }
# => "deux millions vingt-et-un"
```

## Sources

- [OQLF: Plurals of vingt, cent and mille](https://vitrinelinguistique.oqlf.gouv.qc.ca/21532/la-grammaire/les-determinants/determinants-numeraux/pluriel-de-vingt-de-cent-et-de-mille): Numeral agreement.
- [OQLF: Writing Numerals](https://vitrinelinguistique.oqlf.gouv.qc.ca/23494/la-typographie/nombres/ecriture-des-determinants-numeraux): Numeral spelling conventions.
- [Le Robert: Agreement After Zero](https://dictionnaire.lerobert.com/guide/accord-du-nom-apres-zero): Singular zéro euro and the contexts permitting a plural.
- [Unicode CLDR: Plural Rules](https://unicode.org/cldr/charts/47/supplemental/language_plural_rules.html): French singular and plural categories for whole numbers and decimals.
