# Features

What each bundled language supports, generated from its locale file and classes by `bundle exec ruby script/features.rb`; a spec fails when this page is out of date. The [README](../README.md#options--опции--options) documents the options every language shares, and each language's page its own.

* **Decimals**: floats such as `21.77.to_words` read without a unit; *fraction* also reads them as a fraction with `fraction: true`.
* **Gender** and **Case**: the values of `gender:` and `case:`; *animate* adds `animate:`.
* **Ordinals**: the numbers `ordinal: true` spells, all of them up to the largest number unless a range is given.
* **Largest number**: numbers from this power of ten raise `RangeError`.
* **Other options**: options of the language's own.


| Language | Decimals | Gender | Case | Ordinals | Largest number | Other options |
| --- | --- | --- | --- | --- | --- | --- |
| [`ar`](languages/ar.md) | yes | — | — | 1 to 99 | 10<sup>21</sup> | — |
| [`az`](languages/az.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`bg`](languages/bg.md) | yes | male, female, neuter | — | all | 10<sup>21</sup> | — |
| [`bn`](languages/bn.md) | yes | — | — | all | unlimited | — |
| [`cs`](languages/cs.md) | yes | male, female, neuter | — | 0 to 9999 | 10<sup>30</sup> | — |
| [`da`](languages/da.md) | yes | common, neuter | — | all | 10<sup>21</sup> | — |
| [`de`](languages/de.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`el`](languages/el.md) | yes | male, female, neuter | — | 0 to 9999 | 10<sup>15</sup> | — |
| [`en`](languages/en.md) | yes, fraction | — | — | all | 10<sup>48</sup> | `hundreds_with_union`, `pronounced`, `remove_hyphen` |
| [`en-GB`](languages/en-GB.md) | yes, fraction | — | — | all | 10<sup>48</sup> | `hundreds_with_union`, `pronounced`, `remove_hyphen` |
| [`es`](languages/es.md) | yes | male, female | — | all | 10<sup>48</sup> | `apocopated` |
| [`et`](languages/et.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`fi`](languages/fi.md) | yes | — | — | all | 10<sup>15</sup> | — |
| [`fr`](languages/fr.md) | yes, fraction | — | — | all | 10<sup>36</sup> | `spelling` |
| [`fr-CH`](languages/fr-CH.md) | yes, fraction | — | — | all | 10<sup>36</sup> | `spelling` |
| [`he`](languages/he.md) | yes | male, female | — | all | 10<sup>15</sup> | — |
| [`hi`](languages/hi.md) | yes | male, female | — | all | unlimited | — |
| [`hu`](languages/hu.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`hy`](languages/hy.md) | yes | — | — | all | 10<sup>18</sup> | — |
| [`id`](languages/id.md) | yes | — | — | all | 10<sup>15</sup> | — |
| [`it`](languages/it.md) | yes, fraction | — | — | all | 10<sup>48</sup> | — |
| [`ja`](languages/ja.md) | yes | — | — | all | unlimited | `script` |
| [`ka`](languages/ka.md) | yes | — | — | all | 10<sup>15</sup> | — |
| [`kk`](languages/kk.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`ko`](languages/ko.md) | yes | — | — | all | unlimited | — |
| [`lt`](languages/lt.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`lv`](languages/lv.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`ms`](languages/ms.md) | yes | — | — | all | 10<sup>15</sup> | — |
| [`nb`](languages/nb.md) | yes | male, female, neuter | — | all | 10<sup>21</sup> | — |
| [`nl`](languages/nl.md) | yes | — | — | all | 10<sup>36</sup> | `pronounced`, `tens_of_hundreds` |
| [`pl`](languages/pl.md) | yes | male, female, neuter | — | 0 to 999 | 10<sup>48</sup> | — |
| [`pt`](languages/pt.md) | yes, fraction | male, female | — | all | 10<sup>36</sup> | — |
| [`pt-BR`](languages/pt-BR.md) | yes, fraction | male, female | — | all | 10<sup>36</sup> | — |
| [`ro`](languages/ro.md) | yes | male, female, neuter | — | all | 10<sup>18</sup> | — |
| [`ru`](languages/ru.md) | yes | male, female, neuter | nominative, genitive, dative, accusative, instrumental, prepositional, animate | all | 10<sup>36</sup> | — |
| [`sk`](languages/sk.md) | yes | male, female, neuter | — | all | 10<sup>21</sup> | — |
| [`sv`](languages/sv.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`th`](languages/th.md) | yes | — | — | all | unlimited | — |
| [`tr`](languages/tr.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`uk`](languages/uk.md) | yes | male, female, neuter | nominative, genitive, dative, accusative, instrumental, prepositional, vocative, animate | all | 10<sup>36</sup> | — |
| [`ur`](languages/ur.md) | yes | male, female | — | all | unlimited | — |
| [`vi`](languages/vi.md) | yes | — | — | all | 10<sup>18</sup> | — |
| [`zh`](languages/zh.md) | yes | — | — | all | unlimited | — |
