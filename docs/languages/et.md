# Estonian (`et`)

Eesti is the Estonian name of the language. One hundred and one thousand are sada and tuhat, rather than the also valid ükssada and üks tuhat. A million and larger scales keep one. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:et) { 0.to_words }
# => "null"

I18n.with_locale(:et) { 21.to_words }
# => "kakskümmend üks"

I18n.with_locale(:et) { 231.to_words }
# => "kakssada kolmkümmend üks"

I18n.with_locale(:et) { 4030.to_words }
# => "neli tuhat kolmkümmend"

I18n.with_locale(:et) { 1_000_100.to_words }
# => "üks miljon sada"

I18n.with_locale(:et) { 100.to_words }
# => "sada"

I18n.with_locale(:et) { 1_000.to_words }
# => "tuhat"

I18n.with_locale(:et) { 2_000_000_000.to_words }
# => "kaks miljardit"

I18n.with_locale(:et) { [1, 2, 3].to_words }
# => ["üks", "kaks", "kolm"]

I18n.with_locale(:et) { [11, 22, 133].to_words }
# => ["üksteist", "kakskümmend kaks", "sada kolmkümmend kolm"]
```

## Decimals

Decimals are read with koma and then each fractional digit, including leading zeros, as Unicode CLDR reads them.

```ruby
I18n.with_locale(:et) { 3.14.to_words }
# => "kolm koma üks neli"

I18n.with_locale(:et) { 21.05.to_words }
# => "kakskümmend üks koma null viis"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:et) { 0.1.to_words(precision: 2) }
# => "null koma üks null"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:et) { 21.77.to_words(micro_separator: 'punkt') }
# => "kakskümmend üks punkt seitse seitse"
```

### Ordinal

The `ordinal: true` option makes the last word ordinal and puts the words before it in the genitive ("kahekümne esimene"). Ordinals are experimental until a native speaker reviews them, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

```ruby
I18n.with_locale(:et) { 1.to_words(ordinal: true) }
# => "esimene"

I18n.with_locale(:et) { 21.to_words(ordinal: true) }
# => "kahekümne esimene"

I18n.with_locale(:et) { 100.to_words(ordinal: true) }
# => "sajas"

I18n.with_locale(:et) { 1_001.to_words(ordinal: true) }
# => "tuhande esimene"

I18n.with_locale(:et) { 2_000.to_words(ordinal: true) }
# => "kahe tuhandes"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part and keeps koma.

```ruby
I18n.with_locale(:et) { 0.7.to_words(remove_zero: true) }
# => "koma seitse"
```

## Sources

- [EKI Sõnaveeb: sada](https://sonaveeb.ee/search/unif/dlall/dsall/sada/1/est): Hundred and its accepted variants.
- [EKI Sõnaveeb: tuhat](https://sonaveeb.ee/search/unif/dlall/dsall/tuhat/1/est): Thousand and its accepted variants.
- [EKI: Numeral Spelling](https://teatmik.eki.ee/teatmik/arvsonade-kokku-ja-lahkukirjutamine/): Joining and separating numeral components.
- [Unicode CLDR: Estonian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/et.xml): The spell-out rules ICU uses to write numbers in words.
