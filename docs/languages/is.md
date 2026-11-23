# Icelandic (`is`)

Íslenska is the Icelandic name of the language. It is experimental until a native speaker reviews it, see [#255](https://github.com/kslazarev/numbers_and_words/issues/255).

One to four agree in gender with what is counted (einn, ein, eitt); see [Gender](#gender). "Og" comes before the last element of a number. It goes between tens and ones (tuttugu og einn), or before a last part that is a single element: a number below twenty, a ten, or a round hundred or thousand (eitt hundrað og tuttugu, eitt þúsund og eitt hundrað). It doesn't go before a part that has its own "og" (eitt hundrað tuttugu og einn). Numbers up to 10<sup>36</sup> - 1 are supported; larger numbers raise `RangeError`.

Hundrað and þúsund are neuter and counted with eitt, tvö (eitt hundrað, tvö hundruð, tuttugu og eitt þúsund). Milljón and the other words in -jón are feminine (ein milljón, tvær milljónir), and milljarður and the other words in -arður are masculine (einn milljarður, tveir milljarðar). A count ending in one, but not in eleven, takes the singular (tuttugu og ein milljón). Scale words follow the long scale used in Iceland, with milljarður for 10<sup>9</sup>, billjón for 10<sup>12</sup> and billjarður for 10<sup>15</sup>. Unicode CLDR stops at billjarður. The names from trilljón (10<sup>18</sup>) up to kvintilljarður (10<sup>33</sup>) follow the same pattern and need a native speaker's review.

Numbers are spelled in the nominative only. Icelandic also declines one to four in the accusative, dative and genitive, which isn't supported.

## Examples

```ruby
I18n.with_locale(:is) { 0.to_words }
# => "núll"

I18n.with_locale(:is) { 21.to_words }
# => "tuttugu og einn"

I18n.with_locale(:is) { 120.to_words }
# => "eitt hundrað og tuttugu"

I18n.with_locale(:is) { 231.to_words }
# => "tvö hundruð þrjátíu og einn"

I18n.with_locale(:is) { 1100.to_words }
# => "eitt þúsund og eitt hundrað"

I18n.with_locale(:is) { 123_456.to_words }
# => "eitt hundrað tuttugu og þrjú þúsund fjögur hundruð fimmtíu og sex"

I18n.with_locale(:is) { 21_000_000.to_words }
# => "tuttugu og ein milljón"

I18n.with_locale(:is) { 2_000_000_000.to_words }
# => "tveir milljarðar"

I18n.with_locale(:is) { [1, 2, 3].to_words }
# => ["einn", "tveir", "þrír"]

I18n.with_locale(:is) { [11, 22, 133].to_words }
# => ["ellefu", "tuttugu og tveir", "eitt hundrað þrjátíu og þrír"]
```

## Decimals

Decimals are read with komma followed by each fractional digit, including leading zeros.

```ruby
I18n.with_locale(:is) { 3.14.to_words }
# => "þrír komma einn fjórir"

I18n.with_locale(:is) { 21.05.to_words }
# => "tuttugu og einn komma núll fimm"
```

## Options

### Precision

The `precision` option pads the fractional part with zeros to that many digits.

```ruby
I18n.with_locale(:is) { 0.1.to_words(precision: 2) }
# => "núll komma einn núll"
```

### Micro Separator

The `micro_separator` option replaces the word between the integral and fractional parts.

```ruby
I18n.with_locale(:is) { 21.77.to_words(micro_separator: 'punktur') }
# => "tuttugu og einn punktur sjö sjö"
```

### Gender

With `gender: :male` (the default, einn, tveir, þrír, fjórir), `:female` (ein, tvær, þrjár, fjórar) or `:neuter` (eitt, tvö, þrjú, fjögur), the number takes the gender of what is counted. It applies to one to four in the last part of a number. The counts of hundrað, þúsund and the larger scale words keep the gender of the scale word.

```ruby
I18n.with_locale(:is) { 2.to_words(gender: :male) }
# => "tveir"

I18n.with_locale(:is) { 22.to_words(gender: :female) }
# => "tuttugu og tvær"

I18n.with_locale(:is) { 1004.to_words(gender: :neuter) }
# => "eitt þúsund og fjögur"
```

### Ordinal

With `ordinal: true`, every element becomes ordinal, with "og" where the cardinal has it (tuttugasti og fyrsti, hundraðasti og fyrsti). A one before a scale word is left out (hundraðasti, þúsundasti, milljónasti). A one-word count is written together with hundraðasti and þúsundasti (tvöhundraðasti, tvöþúsundasti). A longer count, or the count of a million and larger, is written apart (tuttugu og eitt þúsundasti, tvær milljónasti). Ordinals take the requested gender: fyrsti, annar in the masculine, fyrsta, önnur in the feminine and fyrsta, annað in the neuter. They are spelled in the nominative singular only. The ordinals of compound numbers above a hundred, and of millions and larger, need a native speaker's review.

```ruby
I18n.with_locale(:is) { 1.to_words(ordinal: true) }
# => "fyrsti"

I18n.with_locale(:is) { 21.to_words(ordinal: true) }
# => "tuttugasti og fyrsti"

I18n.with_locale(:is) { 2000.to_words(ordinal: true) }
# => "tvöþúsundasti"

I18n.with_locale(:is) { 22.to_words(ordinal: true, gender: :female) }
# => "tuttugasta og önnur"
```

### Remove Zero

With `remove_zero: true`, a zero integral part is omitted and komma is kept.

```ruby
I18n.with_locale(:is) { 0.7.to_words(remove_zero: true) }
# => "komma sjö"
```

## Sources

- [Wikibooks: Isländisch/Zahlen](https://de.wikibooks.org/wiki/Isl%C3%A4ndisch/_Zahlen): Gendered one to four, hundrað and hundruð, milljón and milljarður, and the ordinals including tuttugasti og fyrsti, hundraðasti og fyrsti and tvöþúsundasti.
- [Icelandic Wikipedia: Stórar tölur](https://is.wikipedia.org/wiki/St%C3%B3rar_t%C3%B6lur): The long-scale names from milljón to kvintilljarður.
- [Unicode CLDR: Icelandic Number Spellout Rules](https://github.com/unicode-org/cldr/blob/main/common/rbnf/is.xml): The spell-out rules ICU uses to write numbers in words.
- [Unicode CLDR: Plural Rules](https://github.com/unicode-org/cldr/blob/main/common/supplemental/plurals.xml): A count ending in one, but not in eleven, is singular.
