# Czech (`cs`)

Čeština. Without `gender`, numbers use the counting forms: jedna for one and dva for two (jedna, dva, tři, dvacet dva); see [Gender](#gender). Numbers up to 10<sup>30</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:cs) { 0.to_words }
# => "nula"

I18n.with_locale(:cs) { 21.to_words }
# => "dvacet jedna"

I18n.with_locale(:cs) { 231.to_words }
# => "dvě stě třicet jedna"

I18n.with_locale(:cs) { 4030.to_words }
# => "čtyři tisíce třicet"

I18n.with_locale(:cs) { 1_000_100.to_words }
# => "jeden milion sto"

I18n.with_locale(:cs) { 2_000_000_000.to_words }
# => "dvě miliardy"

I18n.with_locale(:cs) { [1, 2, 3].to_words }
# => ["jedna", "dva", "tři"]

I18n.with_locale(:cs) { [11, 22, 133].to_words }
# => ["jedenáct", "dvacet dva", "sto třicet tři"]
```

## Decimals

Fraction names use the unaccented spelling consistently with scale words: biliontina, biliontiny and biliontin, matching bilion. Accented variants are also valid Czech.

```ruby
I18n.with_locale(:cs) { 21.77.to_words }
# => "dvacet jedna celých sedmdesát sedm setin"

I18n.with_locale(:cs) { 0.000000000001.to_words(precision: 12) }
# => "nula celá jedna biliontina"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:cs) { 0.1.to_words(precision: 2) }
# => "nula celá deset setin"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:cs) { 21.77.to_words(micro_separator: "plus") }
# => "dvacet jedna celých plus sedmdesát sedm setin"
```

### Gender

`gender: :female`, `gender: :male` or `gender: :neuter`; without it, numbers use the counting forms (jedna, dva) and ordinals the feminine.

```ruby
I18n.with_locale(:cs) { 1.to_words(gender: :female) }
# => "jedna"

I18n.with_locale(:cs) { 1.to_words(gender: :male) }
# => "jeden"

I18n.with_locale(:cs) { 1.to_words(gender: :neuter) }
# => "jedno"

I18n.with_locale(:cs) { 22.to_words }
# => "dvacet dva"

I18n.with_locale(:cs) { 22.to_words(gender: :female) }
# => "dvacet dvě"
```

### Ordinal

`ordinal: true`, optionally with gender. Ordinals are supported below 10,000; larger ones raise `RangeError`.

```ruby
I18n.with_locale(:cs) { 21.to_words(ordinal: true) }
# => "dvacátá první"

I18n.with_locale(:cs) { 21.to_words(gender: :female, ordinal: true) }
# => "dvacátá první"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:cs) { 0.7.to_words(remove_zero: true) }
# => "sedm desetin"
```
