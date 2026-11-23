# Greek (`el`)

Ελληνικά is the Greek name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers agree with the noun they count, and are neuter by default, as when counting (ένα, τρία, τέσσερα, διακόσια, χίλια); see [Gender](#gender). Thousands above one are the feminine noun χιλιάδες (δύο χιλιάδες, είκοσι μία χιλιάδες, διακόσιες χιλιάδες), and millions and larger are neuter (ένα εκατομμύριο, δύο εκατομμύρια). Εκατό becomes εκατόν before the rest of its hundred (εκατόν ένα). Above τρισεκατομμύριο (10<sup>12</sup>), a scale word is a multiplier followed by εκατομμύριο, from τετράκις εκατομμύριο (10<sup>15</sup>) to δεκάκις εκατομμύριο (10<sup>33</sup>). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

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

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:el) { 0.1.to_words(precision: 2) }
# => "μηδέν κόμμα δέκα"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:el) { 21.77.to_words(micro_separator: 'τελεία') }
# => "είκοσι ένα τελεία εβδομήντα επτά"
```

### Gender

The `gender` option, `:neuter` (default), `:male` or `:female`, sets the gender of what is counted. It changes 1, 3, 4, the hundreds from 200 and one thousand in the last group of digits. Thousands above one are always feminine, and millions neuter.

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

The `ordinal: true` option gives the ordinal in the requested gender, neuter by default (πρώτο, εικοστό πρώτο). Below ten thousand every part is an ordinal word (χιλιοστό εκατοστό). From ten thousand, as in Unicode CLDR, a count is cardinal and neuter before the ordinal of its scale word (είκοσι ένα χιλιοστό, δύο εκατομμυριοστό), and a count of one is left out (εκατομμυριοστό). Zero keeps its cardinal form.

```ruby
I18n.with_locale(:el) { 1.to_words(ordinal: true) }
# => "πρώτο"

I18n.with_locale(:el) { 21.to_words(ordinal: true, gender: :male) }
# => "εικοστός πρώτος"

I18n.with_locale(:el) { 2_000.to_words(ordinal: true, gender: :female) }
# => "δισχιλιοστή"

I18n.with_locale(:el) { 21_000.to_words(ordinal: true) }
# => "είκοσι ένα χιλιοστό"

I18n.with_locale(:el) { 2_000_000.to_words(ordinal: true, gender: :male) }
# => "δύο εκατομμυριοστός"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part.

```ruby
I18n.with_locale(:el) { 0.7.to_words(remove_zero: true) }
# => "κόμμα επτά"
```

## Sources

- [Eirmos: Greek Numbers](https://moderngreek.eirmosonline.com/foundation-vocabulary-shorts/numbers/): Cardinal forms and grammatical agreement.
- [Elon.io: Greek Ordinal Numbers](https://elon.io/grammar/greek/numbers/ordinal-numbers): Ordinal formation and gender.
- [Wiktionary: τετράκις εκατομμύριο](https://en.wiktionary.org/wiki/τετράκις_εκατομμύριο): The neuter scale word for 10<sup>15</sup>, a multiplier and εκατομμύριο, followed for the larger scales.
- [Unicode CLDR: Greek Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/el.xml): The spell-out rules ICU uses to write numbers in words.
