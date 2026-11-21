# Upgrading

## Upgrading to 1.1.0

### British English Says "and" After Hundreds

British English (`en-GB`) now adds "and" after hundreds by default, as British usage requires. Previously `en-GB` produced the American form unless `hundreds_with_union: true` was passed. American English (`en`) is unchanged.

```ruby
I18n.with_locale(:'en-GB') { 101.to_words }
# 1.0.x => "one hundred one"
# 1.1.0 => "one hundred and one"
```

To keep the previous output, pass `hundreds_with_union: false`:

```ruby
I18n.with_locale(:'en-GB') { 101.to_words(hundreds_with_union: false) }
# => "one hundred one"
```

See [#251](https://github.com/kslazarev/numbers_and_words/pull/251) for details.

### French Uses the 1990 Spelling Reform

French (`fr`) and Swiss French (`fr-CH`) now follow the 1990 spelling reform (*rectifications de l'orthographe*), hyphenating every numeral in a compound number. The nouns `million`, `milliard` and larger stay separate words, and the plural agreement of `vingts` and `cents` is unchanged.

```ruby
I18n.with_locale(:fr) { 321.to_words }
# 1.0.x => "trois cent vingt et un"
# 1.1.0 => "trois-cent-vingt-et-un"

I18n.with_locale(:fr) { 2_000_021.to_words }
# 1.0.x => "deux millions vingt et un"
# 1.1.0 => "deux millions vingt-et-un"
```

To keep the traditional spelling, pass `traditional: true`:

```ruby
I18n.with_locale(:fr) { 321.to_words(traditional: true) }
# => "trois cent vingt et un"
```

See [#257](https://github.com/kslazarev/numbers_and_words/pull/257) for details.
