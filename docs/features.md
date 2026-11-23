# Features

What each bundled language supports, generated from its locale file and classes by `bundle exec ruby script/features.rb`; a spec fails when this page is out of date. The [README](../README.md#options--опции--options) documents the options every language shares, and each language's page its own.

* **Decimals**: floats such as `21.77.to_words` read without a unit; *fraction* also reads them as a fraction with `fraction: true`.
* **Gender** and **Case**: the values of `gender:` and `case:`; *animate* adds `animate:`.
* **Ordinals**: the numbers `ordinal: true` spells, all of them up to the largest number unless a range is given.
* **Largest number**: numbers from this power of ten raise `RangeError`.
* **Other options**: options of the language's own.


| Language | Decimals | Gender | Case | Ordinals | Largest number | Other options |
| --- | --- | --- | --- | --- | --- | --- |
| [`af`](languages/af.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`ar`](languages/ar.md) | yes | male, female | — | 1 to 99 | 10<sup>36</sup> | — |
| [`az`](languages/az.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`be`](languages/be.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`bg`](languages/bg.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`bn`](languages/bn.md) | yes | — | — | all | unlimited | — |
| [`bs`](languages/bs.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`ca`](languages/ca.md) | yes | male, female | — | all | 10<sup>42</sup> | — |
| [`cs`](languages/cs.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`cy`](languages/cy.md) | yes | male, female | — | from 1 | 10<sup>36</sup> | `vigesimal` |
| [`da`](languages/da.md) | yes | common, neuter | — | all | 10<sup>36</sup> | — |
| [`de`](languages/de.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`el`](languages/el.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`en`](languages/en.md) | yes, fraction | — | — | all | 10<sup>48</sup> | `hundreds_with_union`, `pronounced`, `remove_hyphen` |
| [`en-GB`](languages/en-GB.md) | yes, fraction | — | — | all | 10<sup>48</sup> | `hundreds_with_union`, `pronounced`, `remove_hyphen` |
| [`eo`](languages/eo.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`es`](languages/es.md) | yes | male, female | — | all | 10<sup>48</sup> | `apocopated` |
| [`et`](languages/et.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`fa`](languages/fa.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`fi`](languages/fi.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`fil`](languages/fil.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`fr`](languages/fr.md) | yes, fraction | male, female | — | all | 10<sup>36</sup> | `spelling` |
| [`fr-CH`](languages/fr-CH.md) | yes, fraction | male, female | — | all | 10<sup>36</sup> | `spelling` |
| [`ga`](languages/ga.md) | yes | — | — | from 1 | 10<sup>36</sup> | — |
| [`he`](languages/he.md) | yes | male, female | — | all | 10<sup>36</sup> | — |
| [`hi`](languages/hi.md) | yes | male, female | — | all | unlimited | — |
| [`hr`](languages/hr.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`hu`](languages/hu.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`hy`](languages/hy.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`id`](languages/id.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`is`](languages/is.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`it`](languages/it.md) | yes, fraction | male, female | — | all | 10<sup>48</sup> | — |
| [`ja`](languages/ja.md) | yes | — | — | all | 10<sup>52</sup> | `script` |
| [`ka`](languages/ka.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`kk`](languages/kk.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`km`](languages/km.md) | yes | — | — | all | unlimited | — |
| [`ko`](languages/ko.md) | yes | — | — | all | 10<sup>52</sup> | — |
| [`lo`](languages/lo.md) | yes | — | — | all | unlimited | — |
| [`lt`](languages/lt.md) | yes | male, female | — | all | 10<sup>36</sup> | — |
| [`lv`](languages/lv.md) | yes | male, female | — | all | 10<sup>36</sup> | — |
| [`mk`](languages/mk.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`ms`](languages/ms.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`mt`](languages/mt.md) | yes | male, female | — | all | 10<sup>36</sup> | — |
| [`my`](languages/my.md) | yes | — | — | all | unlimited | — |
| [`nb`](languages/nb.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`nl`](languages/nl.md) | yes | — | — | all | 10<sup>36</sup> | `pronounced`, `tens_of_hundreds` |
| [`pl`](languages/pl.md) | yes | male, female, neuter | nominative, genitive, dative, accusative, instrumental, locative | all | 10<sup>48</sup> | — |
| [`pt`](languages/pt.md) | yes, fraction | male, female | — | all | 10<sup>36</sup> | — |
| [`pt-BR`](languages/pt-BR.md) | yes, fraction | male, female | — | all | 10<sup>36</sup> | — |
| [`ro`](languages/ro.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`ru`](languages/ru.md) | yes | male, female, neuter | nominative, genitive, dative, accusative, instrumental, prepositional, animate | all | 10<sup>36</sup> | — |
| [`sk`](languages/sk.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`sl`](languages/sl.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`sq`](languages/sq.md) | yes | male, female | — | all | 10<sup>36</sup> | — |
| [`sr`](languages/sr.md) | yes | male, female, neuter | — | all | 10<sup>36</sup> | — |
| [`sv`](languages/sv.md) | yes | common, neuter | — | all | 10<sup>36</sup> | — |
| [`sw`](languages/sw.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`ta`](languages/ta.md) | yes | — | — | all | unlimited | — |
| [`th`](languages/th.md) | yes | — | — | all | unlimited | — |
| [`tr`](languages/tr.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`uk`](languages/uk.md) | yes | male, female, neuter | nominative, genitive, dative, accusative, instrumental, prepositional, vocative, animate | all | 10<sup>36</sup> | — |
| [`ur`](languages/ur.md) | yes | male, female | — | all | unlimited | — |
| [`vi`](languages/vi.md) | yes | — | — | all | 10<sup>36</sup> | — |
| [`zh`](languages/zh.md) | yes | — | — | all | unlimited | — |
