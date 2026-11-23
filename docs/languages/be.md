# Belarusian (`be`)

Беларуская is the Belarusian name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers follow the official orthography of 2008 (пяцьдзясят, чацвёрты), not the classical one (чацьверты). Тысяча is feminine (адна тысяча, дзве тысячы) and larger scale words are masculine (адзін мільён, два мільёны, пяць мільёнаў). Scale words follow the short scale up to дэцыльён (10<sup>33</sup>). Unicode CLDR stops at квадрыльён, so the larger names follow the same pattern and await a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`. Unlike Russian and Ukrainian, Belarusian has no `case:` or `animate:` option yet.

## Examples

```ruby
I18n.with_locale(:be) { 0.to_words }
# => "нуль"

I18n.with_locale(:be) { 21.to_words }
# => "дваццаць адзін"

I18n.with_locale(:be) { 756.to_words }
# => "семсот пяцьдзясят шэсць"

I18n.with_locale(:be) { 4030.to_words }
# => "чатыры тысячы трыццаць"

I18n.with_locale(:be) { 5_000_000.to_words }
# => "пяць мільёнаў"

I18n.with_locale(:be) { [1, 2, 3].to_words }
# => ["адзін", "два", "тры"]

I18n.with_locale(:be) { [101, 21, 13].to_words }
# => ["сто адзін", "дваццаць адзін", "трынаццаць"]
```

## Decimals

Decimals are read as a fraction: the integral part with цэлая, then "і" and the fractional part with its denominator (дзясятая, сотая, тысячная), both counted in the feminine. After one the words are singular, after two to four in the nominative plural (дзве цэлыя, тры дзясятыя) and otherwise in the genitive plural (пяць цэлых). More than 23 fractional digits raise `RangeError`.

```ruby
I18n.with_locale(:be) { 21.77.to_words }
# => "дваццаць адна цэлая і семдзесят сем сотых"

I18n.with_locale(:be) { 2.3.to_words }
# => "дзве цэлыя і тры дзясятыя"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:be) { 0.1.to_words(precision: 2) }
# => "нуль цэлых і дзесяць сотых"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:be) { 21.77.to_words(micro_separator: "плюс") }
# => "дваццаць адна цэлая плюс семдзесят сем сотых"
```

### Gender

The `gender` option, `:male` (default), `:female` or `:neuter`, changes one and two in the last group (адзін, адна, адно; два, дзве, два), and the ending of an ordinal.

```ruby
I18n.with_locale(:be) { 1001.to_words(gender: :female) }
# => "адна тысяча адна"

I18n.with_locale(:be) { 21.to_words(gender: :neuter) }
# => "дваццаць адно"
```

### Ordinal

The `ordinal: true` option makes the last word ordinal (дваццаць першы) and joins a round scale to its count in the genitive (двухтысячны, статысячны, дваццаціаднатысячны). A scale group of exactly one omits its one (тысяча першы, мільён першы), while cardinals keep it (адна тысяча адзін). The `gender` option gives the feminine or neuter ending (першая, першае).

```ruby
I18n.with_locale(:be) { 3.to_words(ordinal: true) }
# => "трэці"

I18n.with_locale(:be) { 21.to_words(ordinal: true, gender: :female) }
# => "дваццаць першая"

I18n.with_locale(:be) { 2000.to_words(ordinal: true) }
# => "двухтысячны"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part.

```ruby
I18n.with_locale(:be) { 0.7.to_words(remove_zero: true) }
# => "сем дзясятых"
```

## Sources

- [Wiktionary: Belarusian Number Data](https://en.wiktionary.org/wiki/Module:number_list/data/be): Cardinals and ordinals to 100, the hundreds and their ordinals, and the ordinals of thousands (двухтысячны, статысячны) and millions.
- [Wiktionary: пяцьдзесят](https://en.wiktionary.org/wiki/пяцьдзесят): The superseded spelling of пяцьдзясят.
- [Belarusian Wikipedia: Ундэцыльён](https://be.wikipedia.org/wiki/Ундэцыльён) and [Квадрыльён](https://be.wikipedia.org/wiki/Квадрыльён): The short-scale words up to дэцыльён.
- [Unicode CLDR: Belarusian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/be.xml): The spell-out rules ICU uses to write numbers in words, with the plural forms of the scale words.
