# German (`de`)

Deutsch.

Aliases: `de-AT`, `de-CH`.

## Examples

```ruby
I18n.with_locale(:de) { 0.to_words }
# => "null"

I18n.with_locale(:de) { 21.to_words }
# => "einundzwanzig"

I18n.with_locale(:de) { 231.to_words }
# => "zweihunderteinunddreißig"

I18n.with_locale(:de) { 4030.to_words }
# => "viertausenddreißig"

I18n.with_locale(:de) { 1_000_100.to_words }
# => "eine Million einhundert"

I18n.with_locale(:de) { 2_000_000_000.to_words }
# => "zwei Milliarden"

I18n.with_locale(:de) { [1, 2, 3].to_words }
# => ["eins", "zwei", "drei"]

I18n.with_locale(:de) { [11, 22, 133].to_words }
# => ["elf", "zweiundzwanzig", "einhundertdreiunddreißig"]

I18n.with_locale(:de) { 21.77.to_words }
# => "einundzwanzig Komma sieben sieben"
```

## Ordinal

`ordinal: true` gives the uninflected `-te`/`-ste` form; exact multiples of a million or larger are written as one word.

```ruby
I18n.with_locale(:de) { 21.to_words(ordinal: true) }
# => "einundzwanzigste"

I18n.with_locale(:de) { 101.to_words(ordinal: true) }
# => "einhunderterste"

I18n.with_locale(:de) { 2_000_000.to_words(ordinal: true) }
# => "zweimillionste"
```

## Decimals

Decimals are read with `Komma` followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:de) { 3.05.to_words }
# => "drei Komma null fünf"

I18n.with_locale(:de) { 3.14.to_words }
# => "drei Komma eins vier"
```
