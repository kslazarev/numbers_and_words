# Kazakh (`kk`)

Қазақша.

## Examples

```ruby
I18n.with_locale(:kk) { 0.to_words }
# => "нөл"

I18n.with_locale(:kk) { 21.to_words }
# => "жиырма бір"

I18n.with_locale(:kk) { 231.to_words }
# => "екі жүз отыз бір"

I18n.with_locale(:kk) { 4030.to_words }
# => "төрт мың отыз"

I18n.with_locale(:kk) { 1_000_100.to_words }
# => "бір миллион жүз"

I18n.with_locale(:kk) { 2_000_000_000.to_words }
# => "екі миллиард"

I18n.with_locale(:kk) { [1, 2, 3].to_words }
# => ["бір", "екі", "үш"]

I18n.with_locale(:kk) { [11, 22, 133].to_words }
# => ["он бір", "жиырма екі", "жүз отыз үш"]
```

## Decimals

Decimals are not supported yet.

## Options

### Precision

`precision` pads the fractional part of a decimal, so it has no effect until decimals are supported.

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts of a decimal, so it has no effect until decimals are supported.

### Ordinal

`ordinal: true` adds -ыншы or -інші to the last word, following vowel harmony ("жиырма бірінші"). Ordinals in this language are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:kk) { 1.to_words(ordinal: true) }
# => "бірінші"

I18n.with_locale(:kk) { 21.to_words(ordinal: true) }
# => "жиырма бірінші"

I18n.with_locale(:kk) { 2_000.to_words(ordinal: true) }
# => "екі мыңыншы"
```
