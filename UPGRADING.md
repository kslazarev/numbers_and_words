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
