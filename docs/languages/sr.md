# Serbian (`sr`)

Српски. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Words are in the Cyrillic script, the Unicode CLDR default for `sr`; the Latin script isn't supported. Numbers are ekavian and written as separate words. As in CLDR, и joins the tens and the ones (двадесет и један); двадесет један is also in use. A thousand alone is хиљаду (хиљаду двеста), and a count of thousands is feminine (две хиљаде, двадесет и једна хиљада). Scale words follow the long scale: милион (10<sup>6</sup>), милијарда (10<sup>9</sup>), билион (10<sup>12</sup>), билијарда and so on up to квинтилијарда (10<sup>33</sup>). Those in -ион are masculine (један милион, два милиона), and those in -ијарда feminine (једна милијарда, две милијарде, пет милијарди). A scale word agrees with the last numeral of its count (двадесет и један милион, сто двадесет и три хиљаде). CLDR stops at билијарда (10<sup>15</sup>); the names from трилион (10<sup>18</sup>) on follow the same pattern and need a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:sr) { 0.to_words }
# => "нула"

I18n.with_locale(:sr) { 21.to_words }
# => "двадесет и један"

I18n.with_locale(:sr) { 1234.to_words }
# => "хиљаду двеста тридесет и четири"

I18n.with_locale(:sr) { 22_000.to_words }
# => "двадесет и две хиљаде"

I18n.with_locale(:sr) { 21_000_000.to_words }
# => "двадесет и један милион"

I18n.with_locale(:sr) { 5_000_000_000.to_words }
# => "пет милијарди"

I18n.with_locale(:sr) { [11, 22, 133].to_words }
# => ["једанаест", "двадесет и два", "сто тридесет и три"]
```

## Decimals

Decimals are read as a neuter whole number with цело, цела or целих, then и and a feminine number of десете, стоте or хиљадите (једна десета, две десете, пет десетих). The forms after two to four need a native speaker's review. Up to eleven fractional digits are supported; more raise `RangeError`.

```ruby
I18n.with_locale(:sr) { 1.5.to_words }
# => "једно цело и пет десетих"

I18n.with_locale(:sr) { 3.14.to_words }
# => "три цела и четрнаест стотих"

I18n.with_locale(:sr) { 0.02.to_words }
# => "нула целих и две стоте"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:sr) { 0.1.to_words(precision: 2) }
# => "нула целих и десет стотих"
```

### Micro Separator

`micro_separator` replaces the и between the integral and fractional parts.

```ruby
I18n.with_locale(:sr) { 2.5.to_words(micro_separator: "плус") }
# => "два цела плус пет десетих"
```

### Gender

`gender: :male` (default), `:female` or `:neuter` changes one and two at the end of the number (један, једна, једно; два, две, два).

```ruby
I18n.with_locale(:sr) { 1.to_words(gender: :male) }
# => "један"

I18n.with_locale(:sr) { 22.to_words(gender: :female) }
# => "двадесет и две"

I18n.with_locale(:sr) { 101.to_words(gender: :neuter) }
# => "сто једно"
```

### Ordinal

`ordinal: true` makes the last word ordinal (двадесет и први), in the requested gender (прва, прво; трећа, треће). A round thousand or larger scale is one word with its count, which is left out when it is one (хиљадити, двехиљадити, милионити, двамилионити). This joined form needs a native speaker's review. Ordinals are spelled up to the largest number.

```ruby
I18n.with_locale(:sr) { 21.to_words(ordinal: true) }
# => "двадесет и први"

I18n.with_locale(:sr) { 23.to_words(ordinal: true, gender: :neuter) }
# => "двадесет и треће"

I18n.with_locale(:sr) { 1001.to_words(ordinal: true, gender: :female) }
# => "хиљаду прва"

I18n.with_locale(:sr) { 2000.to_words(ordinal: true) }
# => "двехиљадити"
```

### Remove Zero

`remove_zero: true` omits a zero integral part; the ordinal of zero stays нулти.

```ruby
I18n.with_locale(:sr) { 0.7.to_words(remove_zero: true) }
# => "седам десетих"
```

## Sources

- [Unicode CLDR: Serbian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/sr.xml): Cardinals up to билијарда (10<sup>15</sup>), the и between tens and ones, and ordinals below a thousand. Its једна хиљаду, милион after two to four and ordinals from a thousand on (десетстоти) aren't followed.
- [Unicode CLDR: Plural Rules](https://github.com/unicode-org/cldr/blob/main/common/supplemental/plurals.xml): The one, few and other forms of scale words and fractions.
- [Зелена учионица: Децимални запис разломка](https://zelenaucionica.com/wp-content/uploads/2022/11/5razr-pojam-decimalnog-broja.pdf): A decimal's whole part counted in целих (0 целих).
