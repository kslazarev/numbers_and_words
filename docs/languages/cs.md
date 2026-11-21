# Czech (`cs`)

Čeština.

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
# => "jeden milion jedno sto"

I18n.with_locale(:cs) { 2_000_000_000.to_words }
# => "dvě miliardy"

I18n.with_locale(:cs) { [1, 2, 3].to_words }
# => ["jedna", "dvě", "tři"]

I18n.with_locale(:cs) { [11, 22, 133].to_words }
# => ["jedenáct", "dvacet dvě", "jedno sto třicet tři"]

I18n.with_locale(:cs) { 21.77.to_words }
# => "dvacet jedna celých sedmdesát sedm setin"
```

## Gender

`gender: :female` (default), :male or :neuter

```ruby
I18n.with_locale(:cs) { 1.to_words(gender: :female) }
# => "jedna"

I18n.with_locale(:cs) { 1.to_words(gender: :male) }
# => "jeden"

I18n.with_locale(:cs) { 1.to_words(gender: :neuter) }
# => "jedno"
```

## Ordinal

`ordinal: true`, optionally with gender

```ruby
I18n.with_locale(:cs) { 21.to_words(ordinal: true) }
# => "dvacátá první"

I18n.with_locale(:cs) { 21.to_words(gender: :female, ordinal: true) }
# => "dvacátá první"
```

## Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:cs) { 0.7.to_words(remove_zero: true) }
# => "sedm desetin"
```
