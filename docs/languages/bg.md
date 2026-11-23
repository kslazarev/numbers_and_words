# Bulgarian (`bg`)

Български. Experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

Numbers use the literary forms (единадесет, двадесет), not the colloquial ones (единайсет, двайсет). "и" joins the last part of each group (двадесет и един, сто и пет), and a one-part last group to the rest (хиляда и един, две хиляди и триста). Хиляда is feminine (две хиляди, двадесет и една хиляди) and larger scale words are masculine (един милион, два милиона). Scale words follow the short scale up to децилион (10<sup>33</sup>). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:bg) { 0.to_words }
# => "нула"

I18n.with_locale(:bg) { 21.to_words }
# => "двадесет и един"

I18n.with_locale(:bg) { 231.to_words }
# => "двеста тридесет и един"

I18n.with_locale(:bg) { 2300.to_words }
# => "две хиляди и триста"

I18n.with_locale(:bg) { 21_000.to_words }
# => "двадесет и една хиляди"

I18n.with_locale(:bg) { 1_000_100.to_words }
# => "един милион и сто"

I18n.with_locale(:bg) { 2_000_000_000.to_words }
# => "два милиарда"

I18n.with_locale(:bg) { [1, 2, 3].to_words }
# => ["един", "два", "три"]

I18n.with_locale(:bg) { [11, 22, 133].to_words }
# => ["единадесет", "двадесет и два", "сто тридесет и три"]
```

## Decimals

Decimals use the formal reading as a whole number and a fraction. The integral part is neuter, followed by the invariable цяло. Then come "и" and the feminine fractional part with its denominator (десета, стотна, хилядна), singular after one and plural otherwise. More than nine fractional digits raise `RangeError`.

```ruby
I18n.with_locale(:bg) { 3.14.to_words }
# => "три цяло и четиринадесет стотни"

I18n.with_locale(:bg) { 21.05.to_words }
# => "двадесет и едно цяло и пет стотни"

I18n.with_locale(:bg) { 1.1.to_words }
# => "едно цяло и една десета"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:bg) { 0.1.to_words(precision: 2) }
# => "нула цяло и десет стотни"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:bg) { 21.77.to_words(micro_separator: "плюс") }
# => "двадесет и едно цяло плюс седемдесет и седем стотни"
```

### Gender

`gender: :male` (default), `:female` or `:neuter` changes one and two in the last group (един, една, едно; два, две).

```ruby
I18n.with_locale(:bg) { 1.to_words(gender: :male) }
# => "един"

I18n.with_locale(:bg) { 21.to_words(gender: :female) }
# => "двадесет и една"

I18n.with_locale(:bg) { 2.to_words(gender: :neuter) }
# => "две"
```

### Ordinal

`ordinal: true` makes the last word ordinal (двадесет и първи) in the requested gender (двадесет и първа). A round scale joins its multiplier, with две before хиляден (двехиляден) and дву before larger scale ordinals (двумилионен).

```ruby
I18n.with_locale(:bg) { 21.to_words(ordinal: true) }
# => "двадесет и първи"

I18n.with_locale(:bg) { 21.to_words(ordinal: true, gender: :female) }
# => "двадесет и първа"

I18n.with_locale(:bg) { 2000.to_words(ordinal: true) }
# => "двехиляден"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:bg) { 0.7.to_words(remove_zero: true) }
# => "седем десети"
```

## Sources

- [Chitanka Dictionary: двехиляден](https://rechnik.chitanka.info/w/двехиляден): The ordinal of two thousand.
- [Dumite Dictionary: двехиляден](https://dumite-bg.com/words/двехиляден): Independent confirmation of the same spelling.
- [Unicode CLDR: Bulgarian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/bg.xml): The spell-out rules ICU uses to write numbers in words.
