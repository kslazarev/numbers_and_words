# English (`en`)

English.

Aliases: `en-AU`, `en-CA`, `en-IN`, `en-US`.

## Examples

```ruby
I18n.with_locale(:en) { 0.to_words }
# => "zero"

I18n.with_locale(:en) { 21.to_words }
# => "twenty-one"

I18n.with_locale(:en) { 231.to_words }
# => "two hundred thirty-one"

I18n.with_locale(:en) { 4030.to_words }
# => "four thousand thirty"

I18n.with_locale(:en) { 1_000_100.to_words }
# => "one million one hundred"

I18n.with_locale(:en) { 2_000_000_000.to_words }
# => "two billion"

I18n.with_locale(:en) { [1, 2, 3].to_words }
# => ["one", "two", "three"]

I18n.with_locale(:en) { [11, 22, 133].to_words }
# => ["eleven", "twenty-two", "one hundred thirty-three"]

I18n.with_locale(:en) { 21.77.to_words }
# => "twenty-one and seventy-seven hundredths"
```

## Ordinal

`ordinal: true`

```ruby
I18n.with_locale(:en) { 21.to_words(ordinal: true) }
# => "twenty-first"

I18n.with_locale(:en) { 133.to_words(ordinal: true) }
# => "one hundred thirty-third"
```

## Remove Hyphen

`remove_hyphen: true` removes the hyphen between tens and ones.

```ruby
I18n.with_locale(:en) { 21.to_words(remove_hyphen: true) }
# => "twenty one"
```

## Hundreds With Union

`hundreds_with_union: true` adds 'and' after hundreds.

```ruby
I18n.with_locale(:en) { 111.to_words(hundreds_with_union: true) }
# => "one hundred and eleven"
```

## Pronounced

`pronounced: true` reads four-digit numbers as they are usually spoken.

```ruby
I18n.with_locale(:en) { 1984.to_words(pronounced: true) }
# => "nineteen eighty-four"

I18n.with_locale(:en) { 1101.to_words(pronounced: true) }
# => "eleven oh one"
```

## Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:en) { 0.7.to_words(remove_zero: true) }
# => "seven tenths"

I18n.with_locale(:en) { [0.1, 0.31, 0.12].to_words(remove_zero: true) }
# => ["one tenth", "thirty-one hundredths", "twelve hundredths"]
```
