# frozen_string_literal: true

require 'yaml'
require_relative 'cldr_rules'

# twitter_cldr warns under ruby -w, which the spec task uses; load it, and the
# RBNF classes it autoloads, quietly.
begin
  verbose = $VERBOSE
  $VERBOSE = nil
  require 'twitter_cldr'
  TwitterCldr::Formatters::Rbnf.const_get(:RuleFormatter)
  TwitterCldr::Formatters::Numbers.const_get(:Fraction)
ensure
  $VERBOSE = verbose
end

# Compares this gem's spelled-out integers with the Unicode CLDR rule-based
# number format (RBNF) spell-out rules bundled with the twitter_cldr gem.
module CldrComparison
  RULES_FILE = File.expand_path('../fixtures/cldr_rules.yml', __dir__)
  EXCEPTIONS_FILE = File.expand_path('../fixtures/cldr_exceptions.yml', __dir__)

  NUMBERS = [
    *0..100,
    101, 110, 111, 200, 999, 1000, 1001, 1100, 2000, 21_000, 100_000, 123_456,
    1_000_000, 2_000_000, 21_000_000, 1_000_000_000, 123_456_789
  ].freeze

  # The gem's options, the CLDR rule set that should produce the same words,
  # and the numbers to compare.
  Comparison = Struct.new(:options, :rule_set, :numbers)

  # Each gem locale maps to a CLDR locale and its comparisons by kind. A kind
  # without a gender is the gem's default output, compared with the CLDR rule
  # set for the gem's default gender, e.g. spellout-cardinal-masculine; a
  # kind such as cardinal/female passes gender: to the gem.
  def self.compare(gem_options, rule_set, numbers = NUMBERS)
    Comparison.new(gem_options, rule_set, numbers)
  end

  def self.gendered(kind, genders, base_options = {}, numbers = NUMBERS)
    genders.to_h do |gem_gender, cldr_gender|
      ["#{kind}/#{gem_gender}", compare(base_options.merge(gender: gem_gender), "spellout-#{kind}-#{cldr_gender}", numbers)]
    end
  end

  # Each case in each gender, compared with spellout-cardinal-<gender>-<case>.
  def self.cases(names, genders)
    names.product(genders.to_a).to_h do |name, (gem_gender, cldr_gender)|
      ["cardinal/#{gem_gender}/#{name}", compare({ gender: gem_gender, case: name }, "spellout-cardinal-#{cldr_gender}-#{name}")]
    end
  end

  # The gem's Arabic ordinals cover 1-99 and Hebrew ordinals start at 1; CLDR spells Russian ordinals only below 100,000
  # and Hungarian ones below a billion.
  def self.within(range)
    NUMBERS.select { |number| range.cover?(number) }
  end

  CARDINAL = { 'cardinal' => compare({}, 'spellout-cardinal') }.freeze
  ORDINAL = { 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal') }.freeze
  FEMALE = { female: 'feminine' }.freeze
  FEMALE_NEUTER = FEMALE.merge(neuter: 'neuter').freeze
  MASCULINE_FEMININE = { male: 'masculine' }.merge(FEMALE).freeze

  LOCALES = {
    af: { cldr: :af, kinds: CARDINAL.merge(ORDINAL) },
    ar: { cldr: :ar, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine', within(1..99)) } },
    az: { cldr: :az, kinds: CARDINAL.merge(ORDINAL) },
    # CLDR spells Belarusian ordinals from 1000 with cardinal scale words (дваццаць адна тысяча for the 21000th) or
    # apart (адна тысячны, дзвух тысячны), so they are compared below 1000.
    be: {
      cldr: :be,
      kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine', within(0...1000)) }
        .merge(gendered('cardinal', FEMALE_NEUTER), gendered('ordinal', FEMALE_NEUTER, { ordinal: true }, within(0...1000)))
    },
    bg: {
      cldr: :bg,
      kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine') }
        .merge(gendered('cardinal', FEMALE_NEUTER), gendered('ordinal', FEMALE_NEUTER, ordinal: true))
    },
    # CLDR has no Bosnian ordinals.
    bs: { cldr: :bs, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine') }.merge(gendered('cardinal', FEMALE_NEUTER)) },
    # Czech counts with jedna by default and takes gender: for jeden/jedna/jedno; CLDR has no counting
    # set with jedna, so the default is compared with spellout-numbering, which says jeden.
    # Catalan counts with u, as CLDR spellout-numbering does, not the un of spellout-cardinal-masculine.
    ca: {
      cldr: :ca,
      kinds: { 'cardinal' => compare({}, 'spellout-numbering'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine') }
        .merge(gendered('cardinal', FEMALE), gendered('ordinal', FEMALE, ordinal: true))
    },
    cs: { cldr: :cs, kinds: { 'cardinal' => compare({}, 'spellout-numbering') }.merge(gendered('cardinal', FEMALE_NEUTER.merge(male: 'masculine'))) },
    da: {
      cldr: :da,
      kinds: { 'cardinal' => compare({}, 'spellout-cardinal-common'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-common') }
        .merge(gendered('cardinal', { neuter: 'neuter' }), gendered('ordinal', { neuter: 'neuter' }, ordinal: true))
    },
    de: { cldr: :de, kinds: { 'cardinal' => compare({}, 'spellout-numbering') }.merge(ORDINAL) },
    el: {
      cldr: :el,
      kinds: { 'cardinal' => compare({}, 'spellout-cardinal-neuter'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-neuter') }
        .merge(gendered('cardinal', MASCULINE_FEMININE), gendered('ordinal', MASCULINE_FEMININE, { ordinal: true }))
    },
    en: { cldr: :en, kinds: CARDINAL.merge(ORDINAL) },
    # Spanish counts with uno, as CLDR spellout-numbering does; apocopated: true gives the un of spellout-cardinal-masculine.
    eo: { cldr: :eo, kinds: CARDINAL.merge(ORDINAL) },
    es: {
      cldr: :es,
      kinds: {
        'cardinal' => compare({}, 'spellout-numbering'),
        'cardinal/apocopated' => compare({ apocopated: true }, 'spellout-cardinal-masculine'),
        'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine')
      }.merge(gendered('cardinal', FEMALE), gendered('ordinal', FEMALE, ordinal: true))
    },
    et: { cldr: :et, kinds: CARDINAL },
    fi: { cldr: :fi, kinds: CARDINAL.merge(ORDINAL) },
    fr: { cldr: :fr, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine') } },
    # Hebrew counts with the feminine standalone forms (שתיים, not the construct שתי).
    he: {
      cldr: :he,
      kinds: {
        'cardinal' => compare({}, 'spellout-cardinal-feminine-standalone'),
        'cardinal/male' => compare({ gender: :male }, 'spellout-cardinal-masculine-standalone'),
        'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-feminine', within(1..))
      }.merge(gendered('ordinal', { male: 'masculine' }, { ordinal: true }, within(1..)))
    },
    hi: {
      cldr: :hi,
      kinds: { 'cardinal' => compare({}, 'spellout-cardinal'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine') }
        .merge(gendered('ordinal', FEMALE, ordinal: true))
    },
    # CLDR has no spelled-out Hungarian ordinal for a billion and prints digits.
    # CLDR builds Croatian ordinals from 100 on Czech stems (sti, dvesti, milijuny) and spells the ordinal of zero nulai; only 1-99 are compared.
    hr: {
      cldr: :hr,
      kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine', within(1..99)) }
        .merge(gendered('cardinal', FEMALE_NEUTER), gendered('ordinal', FEMALE_NEUTER, { ordinal: true }, within(1..99)))
    },
    hu: { cldr: :hu, kinds: CARDINAL.merge('ordinal' => compare({ ordinal: true }, 'spellout-ordinal', within(0...1_000_000_000))) },
    hy: { cldr: :hy, kinds: CARDINAL },
    # twitter_cldr 6.14.0 fails to parse the CLDR rule for Indonesian 1st (pertama), which has no trailing semicolon.
    id: { cldr: :id, kinds: CARDINAL.merge('ordinal' => compare({ ordinal: true }, 'spellout-ordinal', NUMBERS - [1])) },
    # CLDR has no Icelandic ordinals.
    is: { cldr: :is, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine') }.merge(gendered('cardinal', FEMALE_NEUTER)) },
    # Italian counts with uno, as CLDR spellout-numbering does, not the un of spellout-cardinal-masculine.
    it: { cldr: :it, kinds: { 'cardinal' => compare({}, 'spellout-numbering'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine') } },
    ja: { cldr: :ja, kinds: CARDINAL.merge(ORDINAL) },
    ka: { cldr: :ka, kinds: CARDINAL },
    kk: { cldr: :kk, kinds: CARDINAL.merge(ORDINAL) },
    km: { cldr: :km, kinds: CARDINAL.merge(ORDINAL) },
    # CLDR Korean ordinals are native (첫째, 첫 번째); the gem's Sino-Korean 제일 has no CLDR rule set.
    ko: { cldr: :ko, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-sinokorean') } },
    lo: { cldr: :lo, kinds: CARDINAL.merge(ORDINAL) },
    lt: { cldr: :lt, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine') } },
    lv: { cldr: :lv, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine') } },
    # CLDR has no Macedonian ordinals.
    mk: { cldr: :mk, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine') }.merge(gendered('cardinal', FEMALE_NEUTER)) },
    ms: { cldr: :ms, kinds: CARDINAL.merge(ORDINAL) },
    # Maltese counts with the independent forms of spellout-numbering (tnejn, tlieta); CLDR spellout-cardinal-masculine
    # and -feminine are the forms before a noun (żewġ, tliet, mitt), which the gem doesn't spell, and CLDR has no
    # Maltese ordinals. twitter_cldr 6.14.0 raises on CLDR Maltese numbers from 11 million up to a billion.
    mt: { cldr: :mt, kinds: { 'cardinal' => compare({}, 'spellout-numbering', NUMBERS - [21_000_000, 123_456_789]) } },
    my: { cldr: :my, kinds: CARDINAL.merge(ORDINAL) },
    nl: { cldr: :nl, kinds: CARDINAL.merge(ORDINAL) },
    pl: {
      cldr: :pl,
      kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine') }.merge(gendered('cardinal', FEMALE_NEUTER))
                                                                         .merge(cases(%i[genitive dative accusative instrumental locative], { male: 'masculine' }.merge(FEMALE_NEUTER)))
    },
    'pt-BR': {
      cldr: :pt,
      kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine') }
        .merge(gendered('cardinal', FEMALE), gendered('ordinal', FEMALE, ordinal: true))
    },
    ro: { cldr: :ro, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine') }.merge(gendered('cardinal', FEMALE_NEUTER)) },
    # CLDR has no spelled-out Russian ordinals from 100,000 and prints digits (100000-й).
    ru: {
      cldr: :ru,
      kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-masculine', within(0...100_000)) }
        .merge(gendered('cardinal', FEMALE_NEUTER), gendered('ordinal', FEMALE_NEUTER, { ordinal: true }, within(0...100_000)))
    },
    sk: { cldr: :sk, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine') }.merge(gendered('cardinal', FEMALE_NEUTER)) },
    # CLDR spells Serbian ordinals from 1,000 as multiples of a hundred (десетстоти for 1,000) and has them only in the masculine.
    sr: {
      cldr: :sr,
      kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal', within(0...1000)) }
        .merge(gendered('cardinal', FEMALE_NEUTER))
    },
    sq: { cldr: :sq, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine') }.merge(gendered('cardinal', FEMALE)) },
    sv: { cldr: :sv, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-neuter'), 'ordinal' => compare({ ordinal: true }, 'spellout-ordinal-neuter') } },
    th: { cldr: :th, kinds: CARDINAL.merge(ORDINAL) },
    tr: { cldr: :tr, kinds: CARDINAL.merge(ORDINAL) },
    uk: { cldr: :uk, kinds: { 'cardinal' => compare({}, 'spellout-cardinal-masculine') }.merge(gendered('cardinal', FEMALE_NEUTER)) },
    vi: { cldr: :vi, kinds: CARDINAL.merge(ORDINAL) },
    zh: { cldr: :zh, kinds: CARDINAL.merge(ORDINAL) }
  }.freeze

  SKIPPED = {
    bn: 'CLDR added Bengali spell-out rules in CLDR 49; twitter_cldr 6.14.0 bundles CLDR 46.1',
    'en-GB': 'CLDR has no en_GB spell-out rules, and its en rules have no British "and" (one hundred and one)',
    'fr-CH': 'twitter_cldr 6.14.0 does not ship the CLDR fr_CH rules',
    nb: 'twitter_cldr 6.14.0 does not resolve the CLDR nb alias to no, so nb has no rule sets',
    pt: 'twitter_cldr 6.14.0 does not ship the CLDR pt_PT rules; CLDR pt is Brazilian and compared as pt-BR',
    sl: 'CLDR 46.1 Slovenian spell-out rules are Croatian words in Slovenian spelling (dvaset ena, tisuću, milijun); Slovenian says enaindvajset, tisoč, milijon',
    ur: 'CLDR added Urdu spell-out rules in CLDR 49; twitter_cldr 6.14.0 bundles CLDR 46.1'
  }.freeze

  module_function

  # Normalization is limited to encoding, never spelling: soft hyphens
  # (U+00AD) and zero-width spaces (U+200B, CLDR's Thai word breaks) are
  # invisible, and repeated whitespace collapses.
  def normalize(words)
    words.delete("\u00AD\u200B").gsub(/\s+/, ' ').strip
  end

  # Per-locale encodings of the same letter: CLDR Romanian uses the legacy
  # cedilla ş/ţ for the comma-below ș/ț, CLDR Maltese writes the apostrophe
  # as U+02BC where the gem uses U+0027 (erba'), CLDR Ukrainian writes the
  # apostrophe as U+02BC where the gem uses U+2019, and CLDR Belarusian writes
  # the Latin i in адзiн for the Cyrillic і.
  LOCALE_NORMALIZATION = {
    be: ->(words) { words.tr('i', 'і') },
    ro: ->(words) { words.tr('şţŞŢ', 'șțȘȚ') },
    mt: ->(words) { words.tr("\u02BC", "'") },
    uk: ->(words) { words.tr("\u02BC", "\u2019") }
  }.freeze

  def normalize_cldr(locale, words)
    normalization = LOCALE_NORMALIZATION[locale]
    normalization ? normalization.call(words) : words
  end

  def gem_words(locale, number, options)
    I18n.with_locale(locale) { normalize(number.to_words(options)) }
  end

  def cldr_words(cldr_locale, number, rule_set)
    words = formatter(cldr_locale).format(number, rule_group: 'SpelloutRules', rule_set: rule_set)
    raise ArgumentError, "CLDR #{cldr_locale} has no rule set #{rule_set}" unless words

    normalize(words)
  end

  def formatter(cldr_locale)
    @formatters ||= {}
    @formatters[cldr_locale] ||= TwitterCldr::Formatters::Rbnf::RbnfFormatter.new(cldr_locale)
  end

  # One number compared: the gem's words, CLDR's, CLDR's after the rules, and the rules that changed them.
  Result = Struct.new(:locale, :kind, :number, :gem, :cldr, :ruled, :rules) do
    def differs?
      gem != ruled
    end
  end

  # Every comparison, with the rules applied.
  def results
    @results ||= LOCALES.flat_map do |locale, config|
      config[:kinds].flat_map do |kind, comparison|
        comparison.numbers.map { |number| result(locale.to_s, kind, number, config, comparison) }
      end
    end
  end

  def result(locale, kind, number, config, comparison)
    gem = gem_words(locale.to_sym, number, comparison.options)
    cldr = normalize_cldr(locale.to_sym, cldr_words(config[:cldr], number, comparison.rule_set))
    Result.new(locale, kind, number, gem, cldr, *apply_rules(locale, kind, number, cldr))
  end

  # CLDR's words after the rules, and the rules that changed them.
  def apply_rules(locale, kind, number, cldr)
    applied = []
    ruled = rules_for(locale).reduce(cldr) do |words, rule|
      next words unless rule.applies?(kind, number)

      rule.apply(words).tap { |changed| applied << rule unless changed == words }
    end
    [ruled, applied]
  end

  def rule_definitions
    YAML.safe_load_file(RULES_FILE) || {}
  end

  # Rules in file order: the shared rules of "*", one per locale they list,
  # then each locale's own. Shared rules give their operation's arguments,
  # scope and affects: count per locale.
  def rules
    @rules ||= rule_definitions.flat_map do |locale, definitions|
      definitions.each_with_index.flat_map do |definition, index|
        locale == '*' ? shared_rules(definition, index) : [Rule.new(locale, index, definition)]
      end
    end
  end

  def shared_rules(definition, index)
    operation = (definition.keys & Rule::OPERATIONS).first
    definition.fetch(operation).map do |locale, arguments|
      scope = arguments.slice(*Rule::SCOPES, 'affects')
      Rule.new("* #{locale}", index, definition.merge(operation => arguments.except(*scope.keys)).merge(scope))
    end
  end

  def rules_for(locale)
    shared, own = rules.select { |rule| [locale, "* #{locale}"].include?(rule.locale) }.partition { |rule| rule.locale.start_with?('*') }
    shared + own
  end

  def exceptions
    YAML.safe_load_file(EXCEPTIONS_FILE) || {}
  end
end
