# Swedish (`sv`)

Svenska. Numbers below a million are written as one word (tjugoettusen, fyratusentrettio), and ett drops a t before tusen (ettusen). This language is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

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

Ordinary decimal readings are not supported yet. Converting a float without `unit` and `subunit`, such as `1.5.to_words`, raises `NumbersAndWords::UnsupportedNumberError`, an `ArgumentError` ("decimals are not supported in :sv"). Amounts with both [`unit` and `subunit`](../../README.md#unit) are supported.

## Options

### Precision

With `unit` and `subunit`, `precision` sets how many decimal places make one subunit (2 by default). It does not enable ordinary decimal readings.

### Micro Separator

`micro_separator` applies to ordinary decimal readings, which are not supported yet. It does not change the separator between a unit and its subunit.

### Ordinal

`ordinal: true` makes the end of the last word ordinal ("tjugoförsta"). Million scale nouns remain separate from their multipliers ("två miljonte"); exactly one millionth is miljonte.

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

## Sources

- [Svenska Akademiens Grammatik, Volume 2](https://svenska.se/SAG_Volym_2.pdf): Cardinal and ordinal grammar, including miljon and miljonte.
- [SVT: två miljonte](https://www.svt.se/sport/fotboll/allsvenskan-slog-rekord-tva-miljoner): An attested separated million ordinal.
- [Unicode CLDR: Swedish Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/sv.xml): The spell-out rules ICU uses to write numbers in words.
