# Macedonian (`mk`)

Македонски. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

"и" joins the last part of each group (дваесет и еден, сто и пет). It also joins a last group of one word to the rest (илјада и еден, две илјади и триста). Hundreds are сто, двесте, триста, then end in -стотини (четиристотини, шестотини). Илјада and the scale words in -ијарда are feminine (две илјади, две милијарди); those in -ион are masculine (два милиони). A count ending in one, but not in eleven, takes the singular (дваесет и една илјада). Scale words follow the long scale: милијарда is 10<sup>9</sup>, билион 10<sup>12</sup> and билијарда 10<sup>15</sup>, up to квинтилијарда (10<sup>33</sup>). Unicode CLDR stops at билијарда; the larger words follow the same pattern and need a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`. The personal forms of masculine nouns (двајца, тројца) are not supported.

## Examples

```ruby
I18n.with_locale(:mk) { 0.to_words }
# => "нула"

I18n.with_locale(:mk) { 21.to_words }
# => "дваесет и еден"

I18n.with_locale(:mk) { 456.to_words }
# => "четиристотини педесет и шест"

I18n.with_locale(:mk) { 2300.to_words }
# => "две илјади и триста"

I18n.with_locale(:mk) { 21_000.to_words }
# => "дваесет и една илјада"

I18n.with_locale(:mk) { 12_332_789.to_words }
# => "дванаесет милиони триста триесет и две илјади седумстотини осумдесет и девет"

I18n.with_locale(:mk) { 2_000_000_000.to_words }
# => "две милијарди"

I18n.with_locale(:mk) { [1, 2, 3].to_words }
# => ["еден", "два", "три"]

I18n.with_locale(:mk) { [11, 22, 133].to_words }
# => ["единаесет", "дваесет и два", "сто триесет и три"]
```

## Decimals

Decimals are read with кома: up to three decimal places as a number, after a нула for each leading zero, and longer ones digit by digit.

```ruby
I18n.with_locale(:mk) { 3.14.to_words }
# => "три кома четиринаесет"

I18n.with_locale(:mk) { 21.05.to_words }
# => "дваесет и еден кома нула пет"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:mk) { 0.1.to_words(precision: 3) }
# => "нула кома сто"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:mk) { 21.77.to_words(micro_separator: "цело и") }
# => "дваесет и еден цело и седумдесет и седум"
```

### Gender

`gender: :male` (default), `:female` or `:neuter` changes one and two in the last group (еден, една, едно; два, две, две) and the ending of an ordinal.

```ruby
I18n.with_locale(:mk) { 1.to_words(gender: :male) }
# => "еден"

I18n.with_locale(:mk) { 21.to_words(gender: :female) }
# => "дваесет и една"

I18n.with_locale(:mk) { 2.to_words(gender: :neuter) }
# => "две"
```

### Ordinal

`ordinal: true` makes the last word ordinal (дваесет и прв) in the requested gender (дваесет и прва, дваесет и прво). A round scale is one word with its count, which is left out when it is one (илјадити, двеилјадити, двамилионити, дваесет и едноилјадити). These joined forms need a native speaker's review.

```ruby
I18n.with_locale(:mk) { 21.to_words(ordinal: true) }
# => "дваесет и прв"

I18n.with_locale(:mk) { 4.to_words(ordinal: true, gender: :female) }
# => "четврта"

I18n.with_locale(:mk) { 2000.to_words(ordinal: true) }
# => "двеилјадити"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps кома.

```ruby
I18n.with_locale(:mk) { 0.7.to_words(remove_zero: true) }
# => "кома седум"
```

## Sources

- [Wikipedia: Macedonian Numerals](https://en.wikipedia.org/wiki/Macedonian_numerals): Cardinals, hundreds, the plural илјади and милиони, the ordinals to ten in each gender and the worked example 12 332 789.
- [Wiktionary: Macedonian Number Data](https://en.wiktionary.org/wiki/Module:number_list/data/mk): Cardinals and ordinals to 100, the hundreds and their ordinals (двестоти, шестоти) and the ordinals of thousands (двеилјадити, петилјадити).
- [Wiktionary: шеснаесет](https://en.wiktionary.org/wiki/шеснаесет): The standard spelling of sixteen.
- [Unicode CLDR: Macedonian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/mk.xml): The spell-out rules ICU uses to write numbers in words, and the long-scale words to билијарда.
