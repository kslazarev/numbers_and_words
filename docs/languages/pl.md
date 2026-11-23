# Polish (`pl`)

Polski. Experimental: masculine-personal forms are not implemented. Numbers up to 10<sup>48</sup> - 1 and up to 48 decimal places are supported, also as ordinals; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:pl) { 0.to_words }
# => "zero"

I18n.with_locale(:pl) { 21.to_words }
# => "dwadzieścia jeden"

I18n.with_locale(:pl) { 231.to_words }
# => "dwieście trzydzieści jeden"

I18n.with_locale(:pl) { 4030.to_words }
# => "cztery tysiące trzydzieści"

I18n.with_locale(:pl) { 1_000_100.to_words }
# => "milion sto"

I18n.with_locale(:pl) { 2_000_000_000.to_words }
# => "dwa miliardy"

I18n.with_locale(:pl) { 21_000.to_words }
# => "dwadzieścia jeden tysięcy"

I18n.with_locale(:pl) { [1, 2, 3].to_words }
# => ["jeden", "dwa", "trzy"]

I18n.with_locale(:pl) { [11, 22, 133].to_words }
# => ["jedenaście", "dwadzieścia dwa", "sto trzydzieści trzy"]
```

## Decimals

```ruby
I18n.with_locale(:pl) { 21.77.to_words }
# => "dwadzieścia jeden całych i siedemdziesiąt siedem setnych"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:pl) { 0.1.to_words(precision: 2) }
# => "zero całych i dziesięć setnych"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:pl) { 21.77.to_words(micro_separator: "plus") }
# => "dwadzieścia jeden całych plus siedemdziesiąt siedem setnych"
```

### Case

`case:` declines a cardinal: `:nominative` (default), `:genitive`, `:dative`, `:accusative`, `:instrumental` or `:locative`, as Unicode CLDR's Polish rules do. Every word declines. A scale word takes the case of its count, in the singular after one and the plural otherwise ("dwóch tysięcy", "pięcioma tysiącami"). A final one after other digits stays jeden ("dwudziestu jeden"). Ordinals are not declined yet: `case:` other than `:nominative` with `ordinal: true` raises `NumbersAndWords::UnsupportedOptionError`.

```ruby
I18n.with_locale(:pl) { 2.to_words(case: :genitive) }
# => "dwóch"

I18n.with_locale(:pl) { 21.to_words(case: :genitive) }
# => "dwudziestu jeden"

I18n.with_locale(:pl) { 5_000.to_words(case: :instrumental) }
# => "pięcioma tysiącami"

I18n.with_locale(:pl) { 1_000_000.to_words(case: :locative) }
# => "milionie"

I18n.with_locale(:pl) { 1.to_words(case: :accusative, gender: :female) }
# => "jedną"

I18n.with_locale(:pl) { 2.to_words(case: :dative, gender: :female) }
# => "dwóm"
```

### Gender

`gender: :male` (default), `:female` or `:neuter`.

```ruby
I18n.with_locale(:pl) { 1.to_words(gender: :female) }
# => "jedna"

I18n.with_locale(:pl) { 22.to_words(gender: :female) }
# => "dwadzieścia dwie"

I18n.with_locale(:pl) { 2.to_words(gender: :neuter) }
# => "dwa"
```

### Ordinal

`ordinal: true`, optionally with `gender:`, makes the tens and ones ordinal and keeps the hundreds and scale words before them cardinal ("dwa tysiące dwudziesty pierwszy"). The ordinal of a round scale is one word with its count in combining form ("dwutysięczny", "stutysięczny"), leaving out a count of one ("tysięczny", "milionowy").

```ruby
I18n.with_locale(:pl) { 21.to_words(ordinal: true) }
# => "dwudziesty pierwszy"

I18n.with_locale(:pl) { 121.to_words(ordinal: true, gender: :female) }
# => "sto dwudziesta pierwsza"

I18n.with_locale(:pl) { 2021.to_words(ordinal: true) }
# => "dwa tysiące dwudziesty pierwszy"

I18n.with_locale(:pl) { 2000.to_words(ordinal: true) }
# => "dwutysięczny"

I18n.with_locale(:pl) { 1_000_000.to_words(ordinal: true, gender: :female) }
# => "milionowa"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:pl) { 0.1.to_words(remove_zero: true) }
# => "jedna dziesiąta"
```

## Sources

- [PWN: Compound Ordinals](https://sjp.pwn.pl/poradnia/haslo/sto-dwadziescia-tysiecy-dwutysieczny;16446.html): Ordinal structure and round thousands.
- [PWN: Numerals in Mathematical Expressions](https://sjp.pwn.pl/poradnia/haslo/liczebnik-w-wyrazeniach-matematycznych;18755.html): Fraction readings and agreement.
- [Unicode CLDR: Polish Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/pl.xml): The spell-out rules ICU uses to write numbers in words.
