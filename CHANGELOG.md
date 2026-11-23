## 1.2.0 (Next)

### Features

  * Spell every language from rule sets in its locale file (`numbers.rules`) with a small rule engine, `NumbersAndWords::Rules`, and declare its options under `numbers.supported_options`, instead of Ruby code for each language; conversions are as fast as in 1.1.0 or up to 3.3 times faster. \[[#361](https://github.com/kslazarev/numbers_and_words/pull/361), [#362](https://github.com/kslazarev/numbers_and_words/pull/362), [#363](https://github.com/kslazarev/numbers_and_words/pull/363)\] \([@dblock](https://github.com/dblock)\)
  * Write error and warning messages as sentences, such as `Numbers in :cs only support values below 10**30.` instead of `numbers must be below 10**30 in :cs`, with one message for ordinals out of range, such as `Ordinals in :ar only support numbers between 1 and 99.`. \[[#361](https://github.com/kslazarev/numbers_and_words/pull/361)\] \([@dblock](https://github.com/dblock)\)
  * Compare what each language supports in [docs/features.md](docs/features.md), generated from the locale files. \[[#365](https://github.com/kslazarev/numbers_and_words/pull/365)\] \([@dblock](https://github.com/dblock)\)
  * Read decimals in Arabic, Armenian, Danish, Estonian, Georgian, Kazakh, Latvian, Lithuanian, Swedish and Turkish, as Unicode CLDR reads them, so that every language reads decimals. \[[#366](https://github.com/kslazarev/numbers_and_words/pull/366)\] \([@dblock](https://github.com/dblock)\)
  * Accept `gender:` in French, German, Italian, Latvian, Lithuanian and Swedish, also for units with a gender, such as "une heure" instead of "un heure" in French. \[[#367](https://github.com/kslazarev/numbers_and_words/pull/367)\] \([@dblock](https://github.com/dblock)\)
  * Spell numbers up to 10<sup>36</sup> in Arabic, Armenian, Bulgarian, Czech, Danish, Finnish, Georgian, Greek, Hebrew, Indonesian, Malay, Norwegian, Romanian, Slovak and Vietnamese, so that every language with scale words reaches it. \[[#368](https://github.com/kslazarev/numbers_and_words/pull/368)\] \([@dblock](https://github.com/dblock)\)
  * Spell Czech, Greek and Polish ordinals up to the largest cardinal instead of raising `RangeError` from 10,000 (Czech, Greek) or 1,000 (Polish). \[[#369](https://github.com/kslazarev/numbers_and_words/pull/369)\] \([@dblock](https://github.com/dblock)\)
  * Your contribution here.

### Bugs

  * Compare the readings the specs test, with the 2.0 defaults, in `script/cldr_differences.rb`, which recorded French spellings that aren't differences as exceptions to review. \[[#369](https://github.com/kslazarev/numbers_and_words/pull/369)\] \([@dblock](https://github.com/dblock)\)
  * Your contribution here.

## 1.1.1 (2026/11/22)

### Bugs

  * Raise `RangeError` for Brazilian Portuguese ordinals of 10**36 and more, instead of spelling them without their highest digits. \[[#325](https://github.com/kslazarev/numbers_and_words/pull/325)\] \([@dblock](https://github.com/dblock)\)
  * Answer `respond_to?` on the options proxy instead of raising `ArgumentError`. \[[#346](https://github.com/kslazarev/numbers_and_words/pull/346)\] \([@dblock](https://github.com/dblock)\)
  * Return no words for `0.to_words(ordinal: true, remove_zero: true)` instead of raising `NoMethodError` in Azerbaijani, Dutch, French, German, Norwegian and Swiss French, or returning the ordinal prefix alone in Chinese, Japanese, Korean, Thai and Vietnamese, and spell the ordinal of zero in Russian and Ukrainian. \[[#344](https://github.com/kslazarev/numbers_and_words/pull/344)\] \([@dblock](https://github.com/dblock)\)

## 1.1.0 (2026/11/22)

### Features
  * Add support for Ruby 4.0. \[[#211](https://github.com/kslazarev/numbers_and_words/pull/211)\]
  * Improve Italian number conversion and floating-point support. \[[#215](https://github.com/kslazarev/numbers_and_words/pull/215)\]
  * Run tests, lint and package checks in separate CI workflows, report coverage to Coveralls, and pin RuboCop. \[[#218](https://github.com/kslazarev/numbers_and_words/pull/218), [#239](https://github.com/kslazarev/numbers_and_words/pull/239), [#238](https://github.com/kslazarev/numbers_and_words/pull/238)\] \([@dblock](https://github.com/dblock)\)
  * Add conversion benchmarks and reduce allocations. \[[#221](https://github.com/kslazarev/numbers_and_words/pull/221), [#222](https://github.com/kslazarev/numbers_and_words/pull/222)\] \([@dblock](https://github.com/dblock)\)
  * Replace Jeweler with a static gemspec, and release with ruby-gem-release. \[[#219](https://github.com/kslazarev/numbers_and_words/pull/219)\] \([@dblock](https://github.com/dblock)\)
  * Remove the i18n version constraint and test i18n 1.6. \[[#237](https://github.com/kslazarev/numbers_and_words/pull/237)\] \([@dblock](https://github.com/dblock)\)
  * Add UPGRADING.md, AGENTS.md and a page per language in docs/languages with every option, and check every documented example in specs. \[[#256](https://github.com/kslazarev/numbers_and_words/pull/256), [#259](https://github.com/kslazarev/numbers_and_words/pull/259), [#260](https://github.com/kslazarev/numbers_and_words/pull/260), [#261](https://github.com/kslazarev/numbers_and_words/pull/261), [#270](https://github.com/kslazarev/numbers_and_words/pull/270), [#278](https://github.com/kslazarev/numbers_and_words/pull/278)\] \([@dblock](https://github.com/dblock)\)
  * Add French and Swiss French `spelling: :reformed` for the 1990 reform (`trois-cent-vingt-et-un`), and `spelling: :traditional`, the default until 2.0. \[[#257](https://github.com/kslazarev/numbers_and_words/pull/257), [#282](https://github.com/kslazarev/numbers_and_words/pull/282)\] \([@dblock](https://github.com/dblock)\)
  * Add experimental Polish, with gender, decimals and ordinals, completing #189. \[[#228](https://github.com/kslazarev/numbers_and_words/pull/228)\] \([@sectasy0](https://github.com/sectasy0), [@dblock](https://github.com/dblock)\)
  * Add German ordinals and decimals ("Komma"), and fix German milliards and larger. \[[#232](https://github.com/kslazarev/numbers_and_words/pull/232)\] \([@dblock](https://github.com/dblock)\)
  * Warn about options or values a language doesn't support, which 2.0 will reject with `NumbersAndWords::UnsupportedOptionError`. \[[#269](https://github.com/kslazarev/numbers_and_words/pull/269)\] \([@dblock](https://github.com/dblock)\)
  * Add a `to_words` command. \[[#231](https://github.com/kslazarev/numbers_and_words/pull/231)\] \([@dblock](https://github.com/dblock)\)
  * Select the bundled locales to load with `NumbersAndWords.configure` or `NumbersAndWords.config.locales`, completing #136. \[[#226](https://github.com/kslazarev/numbers_and_words/pull/226), [#277](https://github.com/kslazarev/numbers_and_words/pull/277)\] \([@seniorihor](https://github.com/seniorihor), [@dblock](https://github.com/dblock)\)
  * Add Dutch `pronounced: true` (1910 is `negentienhonderd tien`). \[[#224](https://github.com/kslazarev/numbers_and_words/pull/224)\] \([@Wessel-Boers](https://github.com/Wessel-Boers), [@dblock](https://github.com/dblock)\)
  * Add experimental Thai. \[[#276](https://github.com/kslazarev/numbers_and_words/pull/276)\] \([@brajo083](https://github.com/brajo083), [@dblock](https://github.com/dblock)\)
  * Add a project logo. \[[#274](https://github.com/kslazarev/numbers_and_words/pull/274)\] \([@dblock](https://github.com/dblock)\)
  * Add a `fallback` option and `NumbersAndWords.config.fallback` for unsupported locales, and raise `NumbersAndWords::UnsupportedLanguageError`, a `RuntimeError`, otherwise. \[[#234](https://github.com/kslazarev/numbers_and_words/pull/234), [#293](https://github.com/kslazarev/numbers_and_words/pull/293)\] \([@dblock](https://github.com/dblock)\)
  * Support `remove_zero` in every language with decimals. \[[#284](https://github.com/kslazarev/numbers_and_words/pull/284)\] \([@dblock](https://github.com/dblock)\)
  * Add Indonesian, and experimental Arabic, Bengali, Bulgarian, Chinese, Finnish, Greek, Hebrew, Hindi, Japanese, Korean, Malay, Norwegian Bokmål, Romanian, Slovak and Urdu. \[[#286](https://github.com/kslazarev/numbers_and_words/pull/286), [#287](https://github.com/kslazarev/numbers_and_words/pull/287), [#288](https://github.com/kslazarev/numbers_and_words/pull/288), [#301](https://github.com/kslazarev/numbers_and_words/pull/301), [#304](https://github.com/kslazarev/numbers_and_words/pull/304), [#305](https://github.com/kslazarev/numbers_and_words/pull/305), [#306](https://github.com/kslazarev/numbers_and_words/pull/306)\] \([@dblock](https://github.com/dblock)\)
  * Support `ordinal: true` in every language. \[[#283](https://github.com/kslazarev/numbers_and_words/pull/283), [#291](https://github.com/kslazarev/numbers_and_words/pull/291), [#297](https://github.com/kslazarev/numbers_and_words/pull/297)\] \([@dblock](https://github.com/dblock)\)
  * Add `fraction: false` to read decimals with a decimal point in English, French, Italian and Portuguese (`twenty-one point seven seven`), and `fraction: true`, the default until 2.0. \[[#289](https://github.com/kslazarev/numbers_and_words/pull/289)\] \([@dblock](https://github.com/dblock)\)
  * Decline Russian and Ukrainian numbers by `case:`, with `animate:` accusatives ("двадцать первого", "двадцати одной тысячи"). \[[#296](https://github.com/kslazarev/numbers_and_words/pull/296), [#298](https://github.com/kslazarev/numbers_and_words/pull/298)\] \([@dblock](https://github.com/dblock)\)
  * Add `unit:`, `subunit:` and `zero_subunit:` to spell amounts with units in the right plural form and gender ("двадцать один рубль", "twenty-one dollars and fifty cents"). \[[#299](https://github.com/kslazarev/numbers_and_words/pull/299), [#302](https://github.com/kslazarev/numbers_and_words/pull/302)\] \([@dblock](https://github.com/dblock)\)
  * Use the standard locale codes `sv`, `uk` and `kk`, and deprecate `se`, `ua` and `kz`. \[[#300](https://github.com/kslazarev/numbers_and_words/pull/300)\] \([@dblock](https://github.com/dblock)\)
  * Add experimental Azerbaijani (`az`), with decimals read as fractions ("üç tam yüzdə on dörd"), ordinals and `remove_zero`, from the digitaz and hydra-billing forks. \[[#308](https://github.com/kslazarev/numbers_and_words/pull/308)\] \([@stager94](https://github.com/stager94), [@NatalieKor](https://github.com/NatalieKor), [@flash-gordon](https://github.com/flash-gordon), [@dblock](https://github.com/dblock)\)
  * Add numeral spelling and grammar references in a Sources section on every language page. \[[#316](https://github.com/kslazarev/numbers_and_words/pull/316)\] \([@dblock](https://github.com/dblock)\)
  * Check spelled-out integers against the Unicode CLDR spell-out rules from twitter_cldr in every language CLDR covers, with every accepted difference reviewed as a rule in `spec/fixtures/cldr_rules.yml` or an exception in `spec/fixtures/cldr_exceptions.yml`. \[[#317](https://github.com/kslazarev/numbers_and_words/pull/317)\] \([@dblock](https://github.com/dblock)\)
  * Release 1.1.0 instead of 2.0.0: keep the 1.0 defaults, error classes, locale codes and Ruby 3.1 support, warn about what 2.0 will change, and add `NumbersAndWords.config.strict_options` to raise for unsupported options. \[[#320](https://github.com/kslazarev/numbers_and_words/pull/320)\] \([@dblock](https://github.com/dblock)\)

### Bugs
  * Fix Latin letters inside Cyrillic words in Russian, Ukrainian and Kazakh, and the Italian spelling of 17 (`diciassette`). \[[#216](https://github.com/kslazarev/numbers_and_words/pull/216)\]
  * Fix Ukrainian separators using Latin letters and validate locale scripts, Unicode normalization and invisible characters. \[[#217](https://github.com/kslazarev/numbers_and_words/pull/217)\] \([@dblock](https://github.com/dblock)\)
  * Fix fixture examples that never ran because of duplicate YAML keys, and fail on duplicate fixture keys. \[[#241](https://github.com/kslazarev/numbers_and_words/pull/241)\] \([@dblock](https://github.com/dblock)\)
  * Fix French plural agreement of `cents` and `quatre-vingts` at the end of a number and before scale nouns (`deux-cents millions`). \[[#242](https://github.com/kslazarev/numbers_and_words/pull/242)\] \([@dblock](https://github.com/dblock)\)
  * Accent Italian compounds ending in -tre (`ventitré`, `milletré`). \[[#243](https://github.com/kslazarev/numbers_and_words/pull/243)\] \([@dblock](https://github.com/dblock)\)
  * Join a Brazilian Portuguese remainder below one hundred with `e` (`um bilhão e vinte e um`), and keep the scale word singular in compound fractions (`décimos de milésimo`). \[[#244](https://github.com/kslazarev/numbers_and_words/pull/244)\] \([@dblock](https://github.com/dblock)\)
  * Use Ukrainian nominative plurals after 2-4 (`два мільйони`) and fix the missing quintillion translation. \[[#245](https://github.com/kslazarev/numbers_and_words/pull/245)\] \([@dblock](https://github.com/dblock)\)
  * Fix `Translation missing` for 10^18 in Czech, German, Estonian, French, Swiss French, Lithuanian and Latvian, and test every scale word in every locale. \[[#246](https://github.com/kslazarev/numbers_and_words/pull/246)\] \([@dblock](https://github.com/dblock)\)
  * Write Russian and Ukrainian compound fraction names as one word (`десятитысячных`), and fix the Ukrainian spelling of `тисячна`. \[[#247](https://github.com/kslazarev/numbers_and_words/pull/247)\] \([@dblock](https://github.com/dblock)\)
  * Use `milijardas` for Lithuanian 10^9 and the short scale above it (`trilijonas` for 10^12). \[[#248](https://github.com/kslazarev/numbers_and_words/pull/248), [#289](https://github.com/kslazarev/numbers_and_words/pull/289)\] \([@dblock](https://github.com/dblock)\)
  * Use the Estonian long scale (`biljon` for 10^12, `triljon` for 10^18). \[[#249](https://github.com/kslazarev/numbers_and_words/pull/249)\] \([@dblock](https://github.com/dblock)\)
  * Join Danish hundreds and final tens or ones with `og` (`et hundrede og et`, `et tusinde og et`). \[[#250](https://github.com/kslazarev/numbers_and_words/pull/250)\] \([@dblock](https://github.com/dblock)\)
  * Say `and` after hundreds in British English with `hundreds_with_union: true` (`one hundred and one`), which 2.0 will make the default; see UPGRADING.md. \[[#251](https://github.com/kslazarev/numbers_and_words/pull/251)\] \([@dblock](https://github.com/dblock)\)
  * Read Dutch decimals as fractions joined with `en` (`eenentwintig en zevenenzeventig honderdsten`) instead of mixing `komma` with fraction words. \[[#252](https://github.com/kslazarev/numbers_and_words/pull/252)\] \([@dblock](https://github.com/dblock)\)
  * Fix Czech decimal agreement (`jedna celá`, `dvě celé`, `třicet jedna setin`) and spell `milion` consistently with `bilion`. \[[#253](https://github.com/kslazarev/numbers_and_words/pull/253)\] \([@dblock](https://github.com/dblock)\)
  * Expand scientific-notation floats before conversion instead of losing their exponent and fractional value. \[[#227](https://github.com/kslazarev/numbers_and_words/pull/227)\] \([@dblock](https://github.com/dblock)\)
  * Fix Italian scale words: `un milione` and `un miliardo` instead of `uno milione`, and keep `mille` apart from a preceding scale word (`un milione mille`). \[[#230](https://github.com/kslazarev/numbers_and_words/pull/230)\] \([@dblock](https://github.com/dblock)\)
  * Fix `NameError` when converting decimals in Portuguese (`pt`), with `remove_zero` support. \[[#233](https://github.com/kslazarev/numbers_and_words/pull/233)\] \([@dblock](https://github.com/dblock)\)
  * Correct Swedish compounds, grammatical gender and long-scale singular/plural names, completing #150. \[[#225](https://github.com/kslazarev/numbers_and_words/pull/225)\] \([@Liggliluff](https://github.com/Liggliluff), [@dblock](https://github.com/dblock)\)
  * Read English numbers of five or more digits normally with `pronounced: true` instead of dropping their leading digits. \[[#273](https://github.com/kslazarev/numbers_and_words/pull/273)\] \([@dblock](https://github.com/dblock)\)
  * Use the usual forms reviewed in #255: Czech `sto`, `tisíc` and ordinal `tisící`, Danish `en` and `tusind`, Hungarian `száz`, `ezer` and `kétezer`, Italian `ventun milioni`, Kazakh `жүз` and `мың`, Armenian `հազար`, and Spanish feminine `una`. \[[#289](https://github.com/kslazarev/numbers_and_words/pull/289)\] \([@dblock](https://github.com/dblock)\)
  * Use European Portuguese forms and the long scale in `pt` (`dezasseis`, `mil milhões`, `um bilião`), say `mil` instead of `um mil`, and join scale words with `e` (`um milhão e cem`); see UPGRADING.md. \[[#309](https://github.com/kslazarev/numbers_and_words/pull/309)\] \([@lomefin](https://github.com/lomefin), [@dblock](https://github.com/dblock)\)
  * Put `de` (`di` in Italian, `d'` before a French vowel) between a unit and a number ending in a scale word of a million or more in Spanish, French, Italian and Portuguese (`um milhão de reais`, `un million d'euros`). \[[#310](https://github.com/kslazarev/numbers_and_words/pull/310)\] \([@dblock](https://github.com/dblock)\)
  * Read negative numbers with the language's minus word (`minus five`, `âm bốn mươi hai`) instead of dropping the sign, raise `RangeError` past a language's largest scale word instead of printing a bare multiplier, raise `NumbersAndWords::UnsupportedNumberError` for decimals in languages without them and for negative ordinals, fix Russian septillions, and join Lithuanian and Latvian multipliers to round ordinals (`dutūkstantasis`, `divtūkstošais`, Latvian `simts`); see UPGRADING.md. \[[#311](https://github.com/kslazarev/numbers_and_words/pull/311)\] \([@dblock](https://github.com/dblock)\)
  * Fix spelling found reviewing every language: British English `one thousand and one`, Dutch long-scale `quadriljoen` and `quintiljard`, Swedish `tjugoettusen`, Norwegian `hundre og ett tusen`, Georgian `ტრილიონი`, Hebrew `שלושת האלפים`, Brazilian Portuguese masculine scale nouns (`dois milhões`), `milionésimo` and decimals read as a number, Italian `centotto`, Romanian `al o miilea`, Vietnamese `mười tám`, Russian and Ukrainian `тысяча первый`, Czech counting forms (`dvacet dva`), Hungarian `két egész`, Spanish `primer`, `veinticinco` and `un euro`, and French `deux-millionième`; see UPGRADING.md. \[[#312](https://github.com/kslazarev/numbers_and_words/pull/312)\] \([@dblock](https://github.com/dblock)\)
  * Fix units, long decimals and decimal ordinals across languages: the form of a number before a unit (`ein Euro`, `eine Mark`, `en krona`, `un euro`, `un leu`, `o liră`, `két forint`), European Portuguese `gender:` (`duas libras`), Hebrew and Arabic unit order and forms (`שקל אחד`, `ديناران`, `أحد عشر دينارًا`) with an Arabic plural rule, the word joining a subunit in Danish, Swedish, Norwegian, Finnish, Estonian and Georgian and attached in Hebrew and Arabic, Russian, Ukrainian and Czech decimals with 16 or more fractional digits, the cardinal form for decimals with `ordinal: true` in every language, one `RangeError` wording, Spanish ordinals of 10^27 and larger, Brazilian Portuguese `quintilionésimo` and `decilionésimo`, and Hindi, Bengali and Urdu ordinals of very large numbers; see UPGRADING.md. \[[#313](https://github.com/kslazarev/numbers_and_words/pull/313)\] \([@dblock](https://github.com/dblock)\)
  * Correct Armenian `կվադրիլիոն`, Bulgarian `двехиляден`, Czech `nula celá`, Slovak `nula celých`, Danish neuter ordinal `andet`, Thai `หนึ่งล้านเอ็ด`, Georgian scale endings, Hungarian compound ordinals, Italian `tremilionitreesimo`, Spanish scale-ordinal prefixes, Russian and Ukrainian ninety-thousandths, and French `zéro euro`. Use consistent numeric Vietnamese decimals, Czech `biliontina`, Estonian `sada` and `tuhat`, German `millionste` and concise Russian and Ukrainian scale ordinals; clarify decimal and ordinal documentation, retain separated Dutch and Swedish million ordinals, and correct the Kuwaiti dinar's 1,000 fils. \[[#314](https://github.com/kslazarev/numbers_and_words/pull/314)\] \([@dblock](https://github.com/dblock)\)
  * Drop the accent of Italian `tré` inside million and larger ordinals (`ventitremilionesimo`), and the leading `un` of compound ordinals (`milioneventitreesimo`). \[[#317](https://github.com/kslazarev/numbers_and_words/pull/317)\] \([@dblock](https://github.com/dblock)\)

## 1.0.3 (Dec 23, 2025)

### Features
  * Upgrade RuboCop to 1.78.0. \[[#208](https://github.com/kslazarev/numbers_and_words/pull/208)\]
  * Add support for Swiss-French language. \[[#210](https://github.com/kslazarev/numbers_and_words/pull/210)\]

## 1.0.2 (Jul 5, 2025)

### Features
  * Add support for Dutch floating-point numbers. \[[#207](https://github.com/kslazarev/numbers_and_words/pull/207)\]

## 1.0.1 (March 7, 2025)

### Features
  * Add support for Ruby 3.4. \[[#204](https://github.com/kslazarev/numbers_and_words/pull/204)\]

### Bugs
  * Fix a few cases in French concerning plurals and union word (mainly 71 and 81). \[[#203](https://github.com/kslazarev/numbers_and_words/pull/203)\]

## 1.0.0 (October 17, 2024)

### Features
  * Add support for Danish language. \[[#197](https://github.com/kslazarev/numbers_and_words/pull/197)\] \([@franta](https://github.com/Franta1205)\)
  * Upgrade RuboCop to 1.63.5. \[[#198](https://github.com/kslazarev/numbers_and_words/pull/198)\]
  * Drop support for Ruby 2.7. \[[#202](https://github.com/kslazarev/numbers_and_words/pull/202)\]
  * Drop support for Ruby 3.0. \[[#202](https://github.com/kslazarev/numbers_and_words/pull/202)\]
  * Add support for Ruby 3.3. \[[#202](https://github.com/kslazarev/numbers_and_words/pull/202)\]

## 0.11.12 (April 22, 2023)

### Features
  * Add support for Ruby 3.1. \[[#187](https://github.com/kslazarev/numbers_and_words/pull/187)\]
  * Drop support for Ruby 2.5. \[[#180](https://github.com/kslazarev/numbers_and_words/pull/180)\]
  * Drop support for Ruby 2.6. \[[#190](https://github.com/kslazarev/numbers_and_words/pull/190)\]
  * Add support for Ruby 3.2. \[[#193](https://github.com/kslazarev/numbers_and_words/pull/193)\]

### Bugs
  * Properly handle Dutch year numbers. \[[#183](https://github.com/kslazarev/numbers_and_words/pull/183)\] \([@mvz](https://github.com/mvz)\)
  * Remove pluralization rules for French. \[[#195](https://github.com/kslazarev/numbers_and_words/pull/195)\]

## 0.11.11 (July 5, 2021)

### Bugs
  * Fix edge cases in Dutch. \[[#182](https://github.com/kslazarev/numbers_and_words/pull/182)\] \([@mvz](https://github.com/mvz)\)

## 0.11.10 (January 5, 2021)

### Bugs
  * Avoid adding all array extensions to the standard Array class. \[[#179](https://github.com/kslazarev/numbers_and_words/pull/179)\]

## 0.11.9 (January 4, 2021)

### Features
  * Add support for Ruby 3.0. \[[#178](https://github.com/kslazarev/numbers_and_words/pull/178)\]

## 0.11.8 (June 6, 2020)

### Features
  * Add support for Kazakh language. \[[#175](https://github.com/kslazarev/numbers_and_words/pull/175)\] \([@j8sus](https://github.com/j8sus)\)

## 0.11.7 (June 1, 2020)

### Features
  * Add support for Ruby 2.7. \[[#172](https://github.com/kslazarev/numbers_and_words/pull/172)\]
  * Drop support for Ruby 2.4.

## 0.11.6 (April 14, 2019)

### Bugs
  * Fix wrong spelling in Spanish with precision. \[[#165](https://github.com/kslazarev/numbers_and_words/pull/165)\]

### Features
  * Add support for Ruby 2.6. \[[#161](https://github.com/kslazarev/numbers_and_words/pull/161)\]
  * Drop support for Ruby 2.2.
  * Drop support for Ruby 2.3.

## 0.11.5 (March 22, 2018)

### Bugs
  * Fix Armenian megs capacity words. \[[#156](https://github.com/kslazarev/numbers_and_words/pull/156)\]

## 0.11.4 (March 20, 2018)

### Features
  * Add support for Armenian language. \[[#155](https://github.com/kslazarev/numbers_and_words/pull/155)\]
  * Improve CI.
  * Improve code readability.

## 0.11.3 (December 3, 2017)

### Features
  * Add support for Vietnamese language. \[[#152](https://github.com/kslazarev/numbers_and_words/pull/152)\]

## 0.11.2 (August 14, 2017)

### Features
  * Add full support for Czech language. \[[#148](https://github.com/kslazarev/numbers_and_words/pull/148)\]

## 0.11.1 (July 23, 2017)

### Features
  * Add support for Spanish floating-point numbers. \[[#146](https://github.com/kslazarev/numbers_and_words/pull/146)\]
  * Add support for French floating-point numbers. \[[#144](https://github.com/kslazarev/numbers_and_words/pull/144)\]

## 0.11.0 (June 26, 2017)

### Features
  * Remove dependency on `ActiveSupport` gem. \[[#141](https://github.com/kslazarev/numbers_and_words/pull/141)\]

## 0.10.6 (June 11, 2017)

### Features
  * Add full support for Brazilian Portuguese. \[[#139](https://github.com/kslazarev/numbers_and_words/pull/139)\]
  * Add option `precision` to `to_words`. \[[#134](https://github.com/kslazarev/numbers_and_words/issues/134)\] \([@neodelf](https://github.com/neodelf)\) \(assignee: [@neodelf](https://github.com/neodelf)\)

### Bugs
  * Fix README typo for 231 in French. \(assignee: [@poilon](https://github.com/poilon)\)
  * Fix big numbers in Spanish. \[[#129](https://github.com/kslazarev/numbers_and_words/pull/129)\] \([@jlduran](https://github.com/jlduran)\) \(assignee: [@jlduran](https://github.com/jlduran)\)
  * Fix typo for number twenty-one in Spanish. \[[#127](https://github.com/kslazarev/numbers_and_words/pull/127)\] \([@jlduran](https://github.com/jlduran)\) \(assignee: [@jlduran](https://github.com/jlduran)\)

## 0.10.5 (March 9, 2016)

### Bugs
  * Fix pluralization rules for Spanish. \[[#122](https://github.com/kslazarev/numbers_and_words/pull/122)\] \([@jlduran](https://github.com/jlduran)\)
  * Fix long scale names in Spanish. \[[#112](https://github.com/kslazarev/numbers_and_words/pull/112)\] \([@jlduran](https://github.com/jlduran)\)
  * Fix Turkish hundred and thousand numbers. \[[#113](https://github.com/kslazarev/numbers_and_words/pull/113)\] \([@cbilgili](https://github.com/cbilgili)\)
  * Fix one/other convention in Spanish and French. \[[#116](https://github.com/kslazarev/numbers_and_words/pull/116)\] \([@joseramonc](https://github.com/joseramonc)\)
  * Fix hundreds in Lithuanian. \[[#117](https://github.com/kslazarev/numbers_and_words/pull/117)\] \([@osegrums](https://github.com/osegrums)\)

## 0.10.4 (March 02, 2015)

### Bugs
  * Fix Lithuanian `other` spelling errors. \[[#109](https://github.com/kslazarev/numbers_and_words/pull/109)\] \([@ViliusLuneckas](https://github.com/ViliusLuneckas)\) \(assignee: [@miks](https://github.com/miks)\)

## 0.10.3 (May 8, 2014)

### Features
  * Add Georgian language. \[[#100](https://github.com/kslazarev/numbers_and_words/pull/100)\] \([@miks](https://github.com/miks)\) \(assignee: [@miks](https://github.com/miks)\)

### Bugs
  * Simplify estonian tens with ones method. \[[#101](https://github.com/kslazarev/numbers_and_words/pull/101)\] \([@miks](https://github.com/miks)\) \(assignee: [@miks](https://github.com/miks)\)

## 0.10.2 (December 18, 2013)

### Bugs
  * Fix latvian one thousand case. \[[#88](https://github.com/kslazarev/numbers_and_words/pull/88)\] \([@miks](https://github.com/miks)\) \(assignee: [@miks](https://github.com/miks)\)

### Supports
  * Reach 100% coverage. \[[#89](https://github.com/kslazarev/numbers_and_words/pull/89)\] \([@miks](https://github.com/miks)\) \(assignee: [@miks](https://github.com/miks)\)

## 0.10.1 (October 22, 2013)

### Bugs
  * Minor orthographic typo in Spanish language. \[[#85](https://github.com/kslazarev/numbers_and_words/pull/85)\] \([@jlduran](https://github.com/jlduran)\) \(assignee: [@jlduran](https://github.com/jlduran)\)

## 0.10.0 (September 03, 2013)

### Features
  * Add Estonian language. \[[#82](https://github.com/kslazarev/numbers_and_words/pull/82)\] \([@miks](https://github.com/miks)\) \(assignee: [@miks](https://github.com/miks)\)
  * Add Lithuanian language. \[[#77](https://github.com/kslazarev/numbers_and_words/pull/77)\] \([@miks](https://github.com/miks)\) \(assignee: [@miks](https://github.com/miks)\)

### Bugs
  * Fix Latvian one hundred cases. \[[#81](https://github.com/kslazarev/numbers_and_words/pull/81)\] \([@miks](https://github.com/miks)\) \(assignee: [@miks](https://github.com/miks)\)

### Supports
  * Added @miks contacts to contributors list in README. \[[#79](https://github.com/kslazarev/numbers_and_words/issues/79)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@miks](https://github.com/miks)\)

## 0.9.0 (May 19, 2013)

### Features
  * Add Latvian language. \[[#70](https://github.com/kslazarev/numbers_and_words/pull/70)\] \([@martinsspringis](https://github.com/martinsspringis)\) \(assignee: [@martinsspringis](https://github.com/martinsspringis)\)
  * Add German language. \[[#52](https://github.com/kslazarev/numbers_and_words/pull/52)\] \([@GSI](https://github.com/GSI)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

### Supports
  * Add @martinsspringis contacts and some examples on Latvian language to README. \[[#71](https://github.com/kslazarev/numbers_and_words/issues/71)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@martinsspringis](https://github.com/martinsspringis)\)

## 0.8.0 (April 29, 2013)

### Features
  * Try to use global language by default, if regional language is missing (EnUs is missing). \[[#65](https://github.com/kslazarev/numbers_and_words/issues/65)\] \([@hubrix](https://github.com/hubrix)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

### Supports
  * Add regional languages aliases to README. \[[#67](https://github.com/kslazarev/numbers_and_words/issues/67)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Remove all warnings in gem. (ruby -w). \[[#66](https://github.com/kslazarev/numbers_and_words/pull/66)\] \([@nikhaldi](https://github.com/nikhaldi)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

## 0.7.1 (April 22, 2013)

### Bugs
  * Wrong hundreds separator with British. \[[#62](https://github.com/kslazarev/numbers_and_words/issues/62)\] \([@eLod](https://github.com/eLod)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

## 0.7.0 (April 14, 2013)

### Features
  * Send number's options through array. \[[#60](https://github.com/kslazarev/numbers_and_words/issues/60)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Add British English. \[[#57](https://github.com/kslazarev/numbers_and_words/issues/57)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@eLod](https://github.com/eLod)\)

## 0.6.1 (April 11, 2013)

### Bugs
  * Extra 'and' added after round hundreds (using hundreds_with_union: true) in English. \[[#58](https://github.com/kslazarev/numbers_and_words/issues/58)\] \([@mafraba](https://github.com/mafraba)\) \(assignee: [@eLod](https://github.com/eLod)\)

## 0.6.0 (March 25, 2013)

### Features
  * Support fractional form for Ukrainian. \[[#54](https://github.com/kslazarev/numbers_and_words/issues/54)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@Shk-Serji](https://github.com/Shk-Serji)\)
  * Support fractional form for Russian. \[[#53](https://github.com/kslazarev/numbers_and_words/issues/53)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Added functionality for spanish . \[[#51](https://github.com/kslazarev/numbers_and_words/pull/51)\] \([@jaambros](https://github.com/jaambros)\) \(assignee: [@jaambros](https://github.com/jaambros)\)
  * Support ordinal form for English and Hungarian. \[[#50](https://github.com/kslazarev/numbers_and_words/issues/50)\] \([@eLod](https://github.com/eLod)\) \(assignee: [@eLod](https://github.com/eLod)\)
  * Add option :remove_hyphen for English language. \[[#45](https://github.com/kslazarev/numbers_and_words/issues/45)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Add option :hundreds_with_union for English language. \[[#44](https://github.com/kslazarev/numbers_and_words/issues/44)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Add Spanish language. (experimental). \[[#42](https://github.com/kslazarev/numbers_and_words/issues/42)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Add Swedish language. (experimental). \[[#41](https://github.com/kslazarev/numbers_and_words/issues/41)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Add Hungarian language. \[[#40](https://github.com/kslazarev/numbers_and_words/pull/40)\] \([@eLod](https://github.com/eLod)\) \(assignee: [@eLod](https://github.com/eLod)\)
  * Add option :gender for Russian language. \[[#39](https://github.com/kslazarev/numbers_and_words/issues/39)\] \([@ermolaev](https://github.com/ermolaev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Gem numbers_and_words not working for decimal values. \[[#38](https://github.com/kslazarev/numbers_and_words/issues/38)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@eLod](https://github.com/eLod)\)

### Supports
  * Update 'code climate' badge. \[[#47](https://github.com/kslazarev/numbers_and_words/issues/47)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Add @eLog contacts and project description on Hungarian language to README. \[[#46](https://github.com/kslazarev/numbers_and_words/issues/46)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@eLod](https://github.com/eLod)\)
  * Add language specific options. \[[#43](https://github.com/kslazarev/numbers_and_words/issues/43)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

## 0.5.0 (October 19, 2012)

### Features
  * Add Italian language. (experimental). \[[#34](https://github.com/kslazarev/numbers_and_words/issues/34)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Add Dutch language. (experimental). \[[#33](https://github.com/kslazarev/numbers_and_words/issues/33)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Add French language. \[[#29](https://github.com/kslazarev/numbers_and_words/pull/29)\] \([@sorich87](https://github.com/sorich87)\) \(assignee: [@sorich87](https://github.com/sorich87)\)

### Supports
  * Add @sorich87 contacts to README. \[[#36](https://github.com/kslazarev/numbers_and_words/issues/36)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@sorich87](https://github.com/sorich87)\)
  * Add Code Climate badge. \[[#35](https://github.com/kslazarev/numbers_and_words/issues/35)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Refactoring tests. \[[#32](https://github.com/kslazarev/numbers_and_words/issues/32)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Refactoring strategies. \[[#31](https://github.com/kslazarev/numbers_and_words/issues/31)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

## 0.4.0 (June 24, 2012)

### Features
  * Add Turkish language. \[[#26](https://github.com/kslazarev/numbers_and_words/issues/26)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@Shk-Serji](https://github.com/Shk-Serji)\)
  * Add Ukrainian language. \[[#25](https://github.com/kslazarev/numbers_and_words/issues/25)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@Shk-Serji](https://github.com/Shk-Serji)\)

### Supports
  * Combine all connections with i18n library in one sub-module. \[[#28](https://github.com/kslazarev/numbers_and_words/issues/28)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Add separate logics for pluralization in different languages. \[[#27](https://github.com/kslazarev/numbers_and_words/issues/27)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

## 0.3.2 (June 24, 2012)

### Bugs
  * Ломает плюрализацию russian. \[[#22](https://github.com/kslazarev/numbers_and_words/issues/22)\] \([@yura](https://github.com/yura)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

## 0.3.1 (May 04, 2012)

### Bugs
  * Fixes 80 in English. \[[#18](https://github.com/kslazarev/numbers_and_words/pull/18)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@dblock](https://github.com/dblock)\)

### Supports
  * Add CHANGELOG.md. \[[#19](https://github.com/kslazarev/numbers_and_words/issues/19)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Readable specs. \[[#16](https://github.com/kslazarev/numbers_and_words/pull/16)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

### Deprecations
  * Add deprecation warning for using gem 'number_to_words_ru' . \[[#21](https://github.com/kslazarev/numbers_and_words/issues/21)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

## 0.3.0 (March 24, 2012)

### Bugs
  * Rails 3 will choke on a nested array. \[[#10](https://github.com/kslazarev/numbers_and_words/pull/10)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@dblock](https://github.com/dblock)\)
  * English fixes and tests. \[[#9](https://github.com/kslazarev/numbers_and_words/pull/9)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@dblock](https://github.com/dblock)\)
  * Namespaced NumbersAndWords. \[[#7](https://github.com/kslazarev/numbers_and_words/pull/7)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@dblock](https://github.com/dblock)\)

### Supports
  * Add contacts to README. \[[#14](https://github.com/kslazarev/numbers_and_words/issues/14)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@dblock](https://github.com/dblock)\)
  * Fixed typo in readme. \[[#13](https://github.com/kslazarev/numbers_and_words/pull/13)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@dblock](https://github.com/dblock)\)
  * Added Travis-ci. \[[#12](https://github.com/kslazarev/numbers_and_words/pull/12)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@dblock](https://github.com/dblock)\)
  * Fix README (Russian & English). \[[#11](https://github.com/kslazarev/numbers_and_words/pull/11)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@dblock](https://github.com/dblock)\)
  * Rename the repo at https://github.com/kslazarev/number_to_words_ru. \[[#8](https://github.com/kslazarev/numbers_and_words/issues/8)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Switch a hard-coded gemspec to Jeweler. \[[#6](https://github.com/kslazarev/numbers_and_words/pull/6)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@dblock](https://github.com/dblock)\)

## 0.3.0.alpha (March 24, 2012)

### Features
  * Check working with ruby 1.9.3. \[[#4](https://github.com/kslazarev/numbers_and_words/issues/4)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

### Bugs
  * Bundle exec rake problem. \[[#3](https://github.com/kslazarev/numbers_and_words/issues/3)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)

### Supports
  * Remove temporary file Gemfile.lock. \[[#5](https://github.com/kslazarev/numbers_and_words/issues/5)\] \([@kslazarev](https://github.com/kslazarev)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
  * Renamed gem from number_to_words_ru to numbers_and_words. \[[#2](https://github.com/kslazarev/numbers_and_words/pull/2)\] \([@dblock](https://github.com/dblock)\) \(assignee: [@kslazarev](https://github.com/kslazarev)\)
