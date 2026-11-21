# British English (`en-GB`)

English (British).

## Examples

```ruby
I18n.with_locale(:'en-GB') { 0.to_words }
# => "zero"

I18n.with_locale(:'en-GB') { 21.to_words }
# => "twenty-one"

I18n.with_locale(:'en-GB') { 231.to_words }
# => "two hundred and thirty-one"

I18n.with_locale(:'en-GB') { 4030.to_words }
# => "four thousand thirty"

I18n.with_locale(:'en-GB') { 1_000_100.to_words }
# => "one million one hundred"

I18n.with_locale(:'en-GB') { 2_000_000_000.to_words }
# => "two billion"

I18n.with_locale(:'en-GB') { [1, 2, 3].to_words }
# => ["one", "two", "three"]

I18n.with_locale(:'en-GB') { [11, 22, 133].to_words }
# => ["eleven", "twenty-two", "one hundred and thirty-three"]

I18n.with_locale(:'en-GB') { 21.77.to_words }
# => "twenty-one point seven seven"
```

## Hundreds With Union

British English adds 'and' after hundreds by default; `hundreds_with_union: false` omits it.

```ruby
I18n.with_locale(:'en-GB') { 111.to_words }
# => "one hundred and eleven"

I18n.with_locale(:'en-GB') { 111.to_words(hundreds_with_union: false) }
# => "one hundred eleven"
```

## Ordinal

`ordinal: true`

```ruby
I18n.with_locale(:'en-GB') { 133.to_words(ordinal: true) }
# => "one hundred and thirty-third"
```

## Remove Hyphen

`remove_hyphen: true` removes the hyphen between tens and ones.

```ruby
I18n.with_locale(:'en-GB') { 21.to_words(remove_hyphen: true) }
# => "twenty one"
```

## Pronounced

`pronounced: true` reads four-digit numbers as they are usually spoken.

```ruby
I18n.with_locale(:'en-GB') { 1984.to_words(pronounced: true) }
# => "nineteen eighty-four"
```

## Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:'en-GB') { 0.7.to_words(remove_zero: true) }
# => "point seven"
```
