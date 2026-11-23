# Persian (`fa`)

فارسی is the Persian name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255). Words are in Persian letters (ک and ی, not the Arabic ك and ي), separated by spaces.

The conjunction و, read -o, joins every part of a number (صد و بیست و یک). A hundred and a thousand are صد and هزار without یک (هزار و یک), while larger scales count one (یک میلیون). Scale words keep their form after any count (دو هزار, سه میلیون). Persian follows the long scale: میلیون (10<sup>6</sup>), میلیارد (10<sup>9</sup>), بیلیون (10<sup>12</sup>), بیلیارد (10<sup>15</sup>), تریلیون (10<sup>18</sup>), تریلیارد, کوآدریلیون, کوآدریلیارد, کوینتیلیون and کوینتیلیارد (10<sup>33</sup>). Unicode CLDR stops at 10<sup>18</sup> and says هزار میلیارد for 10<sup>12</sup>, which is also common. The names from بیلیون follow the Persian Wikipedia table of large numbers and await a native speaker's review. Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Persian is written right to left. The `to_words` method returns the words in logical (reading) order without bidirectional control characters, so they display correctly wherever right-to-left text is supported, such as an HTML element with `dir="rtl"` or `dir="auto"`. Inside left-to-right text, isolate them, for example with `<bdi>` in HTML.

## Examples

```ruby
I18n.with_locale(:fa) { 0.to_words }
# => "صفر"

I18n.with_locale(:fa) { 21.to_words }
# => "بیست و یک"

I18n.with_locale(:fa) { 121.to_words }
# => "صد و بیست و یک"

I18n.with_locale(:fa) { 1_001.to_words }
# => "هزار و یک"

I18n.with_locale(:fa) { 2_021.to_words }
# => "دو هزار و بیست و یک"

I18n.with_locale(:fa) { 1_000_000.to_words }
# => "یک میلیون"

I18n.with_locale(:fa) { 2_000_000_000.to_words }
# => "دو میلیارد"

I18n.with_locale(:fa) { [1, 2, 3].to_words }
# => ["یک", "دو", "سه"]
```

## Decimals

Decimals are read with ممیز followed by each fractional digit, including leading zeros, as Unicode CLDR does. The fraction reading (سه و چهارده صدم) isn't supported.

```ruby
I18n.with_locale(:fa) { 3.14.to_words }
# => "سه ممیز یک چهار"

I18n.with_locale(:fa) { 21.05.to_words }
# => "بیست و یک ممیز صفر پنج"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:fa) { 0.1.to_words(precision: 2) }
# => "صفر ممیز یک صفر"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:fa) { 21.77.to_words(micro_separator: 'نقطه') }
# => "بیست و یک نقطه هفت هفت"
```

### Ordinal

The `ordinal: true` option adds -م to the last word (بیست و یکم, صدم, یک میلیونم). Three is سوم, and thirty سی‌ام, with a zero-width non-joiner between سی and ام as Persian spelling requires. One is یکم, not the Arabic loan اول or نخست, and zero is صفرم. The adjectival ordinals in -مین (سومین) aren't supported. Decimals keep the cardinal form.

```ruby
I18n.with_locale(:fa) { 1.to_words(ordinal: true) }
# => "یکم"

I18n.with_locale(:fa) { 3.to_words(ordinal: true) }
# => "سوم"

I18n.with_locale(:fa) { 23.to_words(ordinal: true) }
# => "بیست و سوم"

I18n.with_locale(:fa) { 30.to_words(ordinal: true) }
# => "سی‌ام"

I18n.with_locale(:fa) { 1_000.to_words(ordinal: true) }
# => "هزارم"
```

### Remove Zero

The `remove_zero: true` option omits a zero integral part and keeps ممیز.

```ruby
I18n.with_locale(:fa) { 0.7.to_words(remove_zero: true) }
# => "ممیز هفت"
```

## Sources

- [Persian Wikipedia: Names of Large Numbers](https://fa.wikipedia.org/wiki/نام_اعداد_بزرگ): The long scale and the names of its powers.
- [Unicode CLDR: Persian Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/fa.xml): The spell-out rules ICU uses to write numbers in words.
