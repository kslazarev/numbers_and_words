# Swiss French (`fr-CH`)

Français (Suisse) is the French name of Swiss French. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:'fr-CH') { 0.to_words }
# => "zéro"

I18n.with_locale(:'fr-CH') { 21.to_words }
# => "vingt et un"

I18n.with_locale(:'fr-CH') { 231.to_words }
# => "deux cent trente et un"

I18n.with_locale(:'fr-CH') { 4030.to_words }
# => "quatre mille trente"

I18n.with_locale(:'fr-CH') { 1_000_100.to_words }
# => "un million cent"

I18n.with_locale(:'fr-CH') { 2_000_000_000.to_words }
# => "deux milliards"

I18n.with_locale(:'fr-CH') { [1, 2, 3].to_words }
# => ["un", "deux", "trois"]

I18n.with_locale(:'fr-CH') { [11, 22, 133].to_words }
# => ["onze", "vingt-deux", "cent trente-trois"]
```

## Decimals

Decimals are read as a fraction joined with `et`. The [`fraction: false`](#fraction) option, the default in 2.0, reads them with `virgule`.

```ruby
I18n.with_locale(:'fr-CH') { 21.77.to_words }
# => "vingt et un et septante-sept centièmes"

I18n.with_locale(:'fr-CH') { 3.05.to_words }
# => "trois et cinq centièmes"

I18n.with_locale(:'fr-CH') { 3.1416.to_words }
# => "trois et mille quatre cent seize dix-millièmes"
```

## Options

### Unit

As in French, zero takes the singular with `one` and `other` unit translations ("zéro euro"). A `zero` unit translation takes precedence.

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:'fr-CH') { 0.1.to_words(precision: 2) }
# => "zéro et dix centièmes"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:'fr-CH') { 21.77.to_words(micro_separator: 'plus') }
# => "vingt et un plus septante-sept centièmes"
```

### Fraction

The `fraction: true` option, the default, reads decimals as a fraction. The `fraction: false` option reads them with `virgule`: up to three decimal places as a number, after a `zéro` for each leading zero, and longer ones digit by digit. It becomes the default in 2.0, and the gem warns about the change (see [UPGRADING](../../UPGRADING.md)).

```ruby
I18n.with_locale(:'fr-CH') { 21.77.to_words(fraction: false) }
# => "vingt et un virgule septante-sept"

I18n.with_locale(:'fr-CH') { 3.05.to_words(fraction: false) }
# => "trois virgule zéro cinq"

I18n.with_locale(:'fr-CH') { 3.1416.to_words(fraction: false) }
# => "trois virgule un quatre un six"
```

### Gender

The `gender` option takes `:male` (default) or `:female`. With `gender: :female`, a final un is une ("septante et une"); the counts of mille and larger scale words stay masculine. A lone premier is première.

```ruby
I18n.with_locale(:'fr-CH') { 1.to_words(gender: :female) }
# => "une"

I18n.with_locale(:'fr-CH') { 71.to_words(gender: :female) }
# => "septante et une"

I18n.with_locale(:'fr-CH') { 21_001.to_words(gender: :female) }
# => "vingt et un mille une"

I18n.with_locale(:'fr-CH') { 1.to_words(ordinal: true, gender: :female) }
# => "première"

I18n.with_locale(:'fr-CH') { 21.to_words(ordinal: true, gender: :female) }
# => "vingt et unième"
```

### Ordinal

The `ordinal: true` option gives the masculine form: 1 alone is premier, and otherwise only the last word takes the suffix -ième, dropping a final e or plural s ("deux centième"). The ordinal of a round million or larger is a numeral, so `spelling: :reformed` joins it to its multiplier with a hyphen ("deux-millionième"; traditional "deux millionième"). Decimals keep the cardinal form.

```ruby
I18n.with_locale(:'fr-CH') { 1.to_words(ordinal: true) }
# => "premier"

I18n.with_locale(:'fr-CH') { 21.to_words(ordinal: true) }
# => "vingt et unième"

I18n.with_locale(:'fr-CH') { 80.to_words(ordinal: true) }
# => "huitantième"

I18n.with_locale(:'fr-CH') { 200.to_words(ordinal: true) }
# => "deux centième"

I18n.with_locale(:'fr-CH') { 2_000_000.to_words(ordinal: true) }
# => "deux millionième"

I18n.with_locale(:'fr-CH') { 2_000_000.to_words(ordinal: true, spelling: :reformed) }
# => "deux-millionième"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part.

```ruby
I18n.with_locale(:'fr-CH') { 0.7.to_words(remove_zero: true) }
# => "sept dixièmes"
```

### Spelling

The `spelling: :traditional` option, the default, puts spaces rather than hyphens around `et`, `cent` and `mille`. The `spelling: :reformed` option follows the 1990 reform, hyphenating every numeral in a compound number except the nouns million, milliard and larger. It becomes the default in 2.0, and the gem warns about the change (see [UPGRADING](../../UPGRADING.md)).

```ruby
I18n.with_locale(:'fr-CH') { 71.to_words }
# => "septante et un"

I18n.with_locale(:'fr-CH') { 321.to_words }
# => "trois cent vingt et un"

I18n.with_locale(:'fr-CH') { 2_000_021.to_words }
# => "deux millions vingt et un"

I18n.with_locale(:'fr-CH') { 71.to_words(spelling: :reformed) }
# => "septante-et-un"

I18n.with_locale(:'fr-CH') { 321.to_words(spelling: :reformed) }
# => "trois-cent-vingt-et-un"

I18n.with_locale(:'fr-CH') { 2_000_021.to_words(spelling: :reformed) }
# => "deux millions vingt-et-un"
```

## Sources

- [Le Robert: huitante](https://dictionnaire.lerobert.com/definition/huitante): The regional word for eighty.
- [Larousse: cent](https://www.larousse.fr/dictionnaires/francais/cent/14089): Hundred forms and agreement.
- [Larousse: billion](https://www.larousse.fr/dictionnaires/francais/billion/9314): The French long-scale number name.
- [OQLF: Writing Numerals](https://vitrinelinguistique.oqlf.gouv.qc.ca/23494/la-typographie/nombres/ecriture-des-determinants-numeraux): Shared French spelling conventions.
- [Le Robert: Agreement After Zero](https://dictionnaire.lerobert.com/guide/accord-du-nom-apres-zero): Singular zéro euro and accepted plural contexts.
- [Unicode CLDR: Swiss French Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/fr_CH.xml): The spell-out rules ICU uses to write numbers in words.
