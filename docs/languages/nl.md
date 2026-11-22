# Dutch (`nl`)

Nederlands. Dutch uses the long scale: miljoen, miljard, biljoen, biljard, triljoen, triljard, quadriljoen, quadriljard, quintiljoen and quintiljard. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

## Examples

```ruby
I18n.with_locale(:nl) { 0.to_words }
# => "nul"

I18n.with_locale(:nl) { 21.to_words }
# => "eenentwintig"

I18n.with_locale(:nl) { 231.to_words }
# => "tweehonderdeenendertig"

I18n.with_locale(:nl) { 4030.to_words }
# => "vierduizend dertig"

I18n.with_locale(:nl) { 1_000_100.to_words }
# => "één miljoen honderd"

I18n.with_locale(:nl) { 2_000_000_000.to_words }
# => "twee miljard"

I18n.with_locale(:nl) { [1, 2, 3].to_words }
# => ["één", "twee", "drie"]

I18n.with_locale(:nl) { [11, 22, 133].to_words }
# => ["elf", "tweeëntwintig", "honderddrieëndertig"]
```

## Decimals

```ruby
I18n.with_locale(:nl) { 21.77.to_words }
# => "eenentwintig en zevenenzeventig honderdsten"
```

## Options

### Precision

`precision` pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:nl) { 0.1.to_words(precision: 2) }
# => "nul en tien honderdsten"
```

### Micro Separator

`micro_separator` replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:nl) { 21.77.to_words(micro_separator: "plus") }
# => "eenentwintig plus zevenenzeventig honderdsten"
```

### Ordinal

`ordinal: true` adds -ste or -de to the last word ("eenentwintigste", "honderdeerste"). As in cardinals, million and larger scales stay apart from their multiplier ("twee miljoenste").

```ruby
I18n.with_locale(:nl) { 1.to_words(ordinal: true) }
# => "eerste"

I18n.with_locale(:nl) { 21.to_words(ordinal: true) }
# => "eenentwintigste"

I18n.with_locale(:nl) { 2_000.to_words(ordinal: true) }
# => "tweeduizendste"

I18n.with_locale(:nl) { 2_000_000.to_words(ordinal: true) }
# => "twee miljoenste"
```

### Pronounced

`pronounced: true` reads four-digit numbers with a nonzero hundreds digit as tens of hundreds, as usually spoken, with a space before the remainder. Other numbers are read as usual.

```ruby
I18n.with_locale(:nl) { 1910.to_words(pronounced: true) }
# => "negentienhonderd tien"

I18n.with_locale(:nl) { 1100.to_words(pronounced: true) }
# => "elfhonderd"

I18n.with_locale(:nl) { 2001.to_words(pronounced: true) }
# => "tweeduizend één"
```

### Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:nl) { 0.7.to_words(remove_zero: true) }
# => "zeven tienden"
```

### Tens of Hundreds

`tens_of_hundreds: true` reads thousands as tens of hundreds.

```ruby
I18n.with_locale(:nl) { 1910.to_words(tens_of_hundreds: true) }
# => "negentienhonderdtien"
```

## Sources

- [Taaladvies: Joining Numerals](https://taaladvies.net/aaneenschrijven-van-telwoorden-algemeen/): Cardinal and ordinal spacing, including separate miljoenste.
- [Algemene Nederlandse Spraakkunst: Numerals](https://e-ans.ivdnt.org/topics/pid/topic-16976121812507965): Grammatical numeral structure and million-scale ordinal examples.
- [Unicode CLDR: Dutch Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/nl.xml): The spell-out rules ICU uses to write numbers in words.
