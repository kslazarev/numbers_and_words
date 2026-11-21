# Greek (`el`)

Ελληνικά. This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers agree with the noun they count. They use the neuter form by default, as when counting (ένα, τρία, τέσσερα, διακόσια, χίλια); see [Gender](#gender). Thousands above one are the feminine noun χιλιάδες (δύο χιλιάδες, είκοσι μία χιλιάδες, διακόσιες χιλιάδες), and millions and larger are neuter (ένα εκατομμύριο, δύο εκατομμύρια). εκατό becomes εκατόν before the rest of its hundred (εκατόν ένα). Numbers up to 999,999,999,999,999 (τρισεκατομμύριο) are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:el) { 0.to_words }
# => "μηδέν"

I18n.with_locale(:el) { 13.to_words }
# => "δεκατρία"

I18n.with_locale(:el) { 21.to_words }
# => "είκοσι ένα"

I18n.with_locale(:el) { 101.to_words }
# => "εκατόν ένα"

I18n.with_locale(:el) { 1_000.to_words }
# => "χίλια"

I18n.with_locale(:el) { 2_000.to_words }
# => "δύο χιλιάδες"

I18n.with_locale(:el) { 21_000.to_words }
# => "είκοσι μία χιλιάδες"

I18n.with_locale(:el) { 1_000_000.to_words }
# => "ένα εκατομμύριο"

I18n.with_locale(:el) { 123_456_789.to_words }
# => "εκατόν είκοσι τρία εκατομμύρια τετρακόσιες πενήντα έξι χιλιάδες επτακόσια ογδόντα εννέα"

I18n.with_locale(:el) { [1, 2, 3].to_words }
# => ["ένα", "δύο", "τρία"]
```

## Decimals

Decimals are read with `κόμμα` followed by the fractional part: up to three decimal places as a number after one `μηδέν` for each leading zero, and longer ones digit by digit. The fractional part uses the neuter form.

```ruby
I18n.with_locale(:el) { 3.14.to_words }
# => "τρία κόμμα δεκατέσσερα"

I18n.with_locale(:el) { 21.05.to_words }
# => "είκοσι ένα κόμμα μηδέν πέντε"

I18n.with_locale(:el) { 3.1416.to_words }
# => "τρία κόμμα ένα τέσσερα ένα έξι"
```

## Options

### Precision

`precision` pads the fractional part with zeros to the given number of digits.

```ruby
I18n.with_locale(:el) { 0.1.to_words(precision: 2) }
# => "μηδέν κόμμα δέκα"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:el) { 21.77.to_words(micro_separator: "τελεία") }
# => "είκοσι ένα τελεία εβδομήντα επτά"
```

### Gender

`gender: :neuter` (the default), `gender: :male` or `gender: :female`, the gender of what is counted. It changes 1, 3, 4, the hundreds from 200 and one thousand in the last group of digits; thousands above one are always feminine and millions neuter.

```ruby
I18n.with_locale(:el) { 1.to_words(gender: :male) }
# => "ένας"

I18n.with_locale(:el) { 3.to_words(gender: :female) }
# => "τρεις"

I18n.with_locale(:el) { 1_200.to_words(gender: :female) }
# => "χίλιες διακόσιες"

I18n.with_locale(:el) { 4.to_words(gender: :neuter) }
# => "τέσσερα"
```

### Ordinal

`ordinal: true` gives the ordinal in the requested gender, neuter by default (πρώτο, εικοστό πρώτο); every part of the number is an ordinal word (χιλιοστό εκατοστό). Ordinals are supported below 10,000, and larger ones raise `RangeError`. Zero keeps its cardinal form.

```ruby
I18n.with_locale(:el) { 1.to_words(ordinal: true) }
# => "πρώτο"

I18n.with_locale(:el) { 21.to_words(ordinal: true, gender: :male) }
# => "εικοστός πρώτος"

I18n.with_locale(:el) { 2_000.to_words(ordinal: true, gender: :female) }
# => "δισχιλιοστή"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:el) { 0.7.to_words(remove_zero: true) }
# => "κόμμα επτά"
```
