# Swedish (`sv`)

Svenska. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers below a million are written as one word (tjugoettusen, fyratusentrettio), and ett drops a t before tusen (ettusen). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:sv) { 0.to_words }
# => "noll"

I18n.with_locale(:sv) { 21.to_words }
# => "tjugoett"

I18n.with_locale(:sv) { 231.to_words }
# => "tvåhundratrettioett"

I18n.with_locale(:sv) { 4030.to_words }
# => "fyratusentrettio"

I18n.with_locale(:sv) { 1_000_100.to_words }
# => "en miljon etthundra"

I18n.with_locale(:sv) { 2_000_000_000.to_words }
# => "två miljarder"

I18n.with_locale(:sv) { [1, 2, 3].to_words }
# => ["ett", "två", "tre"]

I18n.with_locale(:sv) { [11, 22, 133].to_words }
# => ["elva", "tjugotvå", "etthundratrettiotre"]
```

## Decimals

Decimals are read with komma followed by each fractional digit, including leading zeros, as in Unicode CLDR.

```ruby
I18n.with_locale(:sv) { 3.14.to_words }
# => "tre komma ett fyra"

I18n.with_locale(:sv) { 21.05.to_words }
# => "tjugoett komma noll fem"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:sv) { 0.1.to_words(precision: 2) }
# => "noll komma ett noll"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:sv) { 21.77.to_words(micro_separator: "punkt") }
# => "tjugoett punkt sju sju"
```

### Gender

`gender: :neuter` (default) or `gender: :common`. With `:common`, a final ett is en, as before a common-gender noun ("tjugoen"). The counts of tusen stay neuter ("tjugoettusen"), and those of miljon and larger scale words common.

```ruby
I18n.with_locale(:sv) { 1.to_words(gender: :neuter) }
# => "ett"

I18n.with_locale(:sv) { 21.to_words(gender: :neuter) }
# => "tjugoett"

I18n.with_locale(:sv) { 21_001.to_words(gender: :neuter) }
# => "tjugoettusenett"
```

### Ordinal

`ordinal: true` makes the end of the last word ordinal ("tjugoförsta"). Million and larger scales stay apart from their multiplier ("två miljonte"); one millionth is miljonte.

```ruby
I18n.with_locale(:sv) { 1.to_words(ordinal: true) }
# => "första"

I18n.with_locale(:sv) { 21.to_words(ordinal: true) }
# => "tjugoförsta"

I18n.with_locale(:sv) { 2_000.to_words(ordinal: true) }
# => "tvåtusende"

I18n.with_locale(:sv) { 2_000_000.to_words(ordinal: true) }
# => "två miljonte"
```

### Remove Zero

`remove_zero: true` omits a zero integral part and keeps komma.

```ruby
I18n.with_locale(:sv) { 0.7.to_words(remove_zero: true) }
# => "komma sju"
```

## Sources

- [Svenska Akademiens Grammatik, Volume 2](https://svenska.se/SAG_Volym_2.pdf): Cardinal and ordinal grammar, including miljon and miljonte.
- [SVT: två miljonte](https://www.svt.se/sport/fotboll/allsvenskan-slog-rekord-tva-miljoner): An attested separated million ordinal.
- [Unicode CLDR: Swedish Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/sv.xml): The spell-out rules ICU uses to write numbers in words.
