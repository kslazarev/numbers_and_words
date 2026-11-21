# Dutch (`nl`)

Nederlands.

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

I18n.with_locale(:nl) { 21.77.to_words }
# => "eenentwintig en zevenenzeventig honderdsten"
```

## Tens of Hundreds

`tens_of_hundreds: true` reads thousands as tens of hundreds.

```ruby
I18n.with_locale(:nl) { 1910.to_words(tens_of_hundreds: true) }
# => "negentienhonderdtien"
```

## Pronounced

`pronounced: true` reads four-digit numbers with a nonzero hundreds digit as tens of hundreds, as they are usually spoken, with a space before the remainder. Other numbers are read as usual.

```ruby
I18n.with_locale(:nl) { 1910.to_words(pronounced: true) }
# => "negentienhonderd tien"

I18n.with_locale(:nl) { 1100.to_words(pronounced: true) }
# => "elfhonderd"

I18n.with_locale(:nl) { 2001.to_words(pronounced: true) }
# => "tweeduizend één"
```

## Remove Zero

`remove_zero: true` omits a zero integral part.

```ruby
I18n.with_locale(:nl) { 0.7.to_words(remove_zero: true) }
# => "zeven tienden"
```
