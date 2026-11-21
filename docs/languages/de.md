# German (`de`)

Deutsch. This language is experimental: ordinals and decimals are not supported yet, and exact large scales leave trailing spaces.

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
# => "zwei Milliarden  "

I18n.with_locale(:de) { [1, 2, 3].to_words }
# => ["eins", "zwei", "drei"]

I18n.with_locale(:de) { [11, 22, 133].to_words }
# => ["elf", "zweiundzwanzig", "einhundertdreiunddreißig"]
```

Decimals are not supported yet.
