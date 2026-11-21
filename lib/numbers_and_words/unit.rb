# frozen_string_literal: true

module NumbersAndWords
  # The unit option: spells a whole number followed by a unit word that the application translates under units.<key>,
  # with one form per plural category of the locale, and optionally the grammatical gender the number agrees with.
  #   ru: { units: { kopeck: { one: копейка, few: копейки, many: копеек, other: копейки, gender: female } } }
  module Unit
    SCOPE = 'units'
    # Locales whose numbers are written without spaces, so the unit follows without one.
    UNSPACED = %i[th zh].freeze
    SUBUNIT_PLACES = 2
    # After a decimal a unit takes its other form (1.5 dollars, 1,5 рубля, 1,5 koruny), except that French
    # and Portuguese use the singular below 2 (1,5 euro).
    SINGULAR_BELOW_TWO = %i[fr fr-CH pt pt-BR].freeze

    module_function

    # Converts a number, or any array element, with options that are already validated.
    def convert(number, options)
      unit, subunit, options = extract(options)
      return Wrappers.for(number).to_words(options) if unit.nil?

      nominative!(unit, options)
      subunit ? amount(number, unit, subunit, options) : phrase(number, unit, options)
    end

    # A number followed by its unit: "twenty-one dollars", "one point five dollars".
    def phrase(number, unit, options)
      number = number.to_i if number.is_a?(::Float) && (number % 1).zero?
      key = "#{SCOPE}.#{unit}"
      entry = lookup(unit, key)
      return join(Wrappers::Float.new(number).to_words(options), decimal_form(unit, key, entry, number)) if number.is_a?(::Float)

      join(Wrappers.for(number).to_words(with_gender(options, entry)), form(unit, key, count(number, options)))
    end

    # Unit translations have one form per plural category, all in the nominative.
    def nominative!(unit, options)
      grammatical_case = options[:case]
      return if grammatical_case.nil? || grammatical_case.to_sym == :nominative

      raise UnsupportedOptionError, "unit #{unit.inspect} cannot be used with case: #{grammatical_case.inspect} yet; unit forms are nominative"
    end

    # An amount in a unit and a subunit: "twenty-one dollars and fifty cents". precision: sets how many
    # decimal places make one subunit (2 by default), and the amount is rounded half to even to them.
    # A zero subunit is left out unless zero_subunit: true, and a zero unit with remove_zero: true.
    def amount(number, unit, subunit, options)
      raise UnsupportedOptionError, 'subunit cannot be used with ordinal: true' if options[:ordinal]

      whole, part = split(number, options.fetch(:precision, SUBUNIT_PLACES))
      conversion = options.except(:precision, :remove_zero, :zero_subunit)
      amount_parts(whole, part, unit, subunit, options).map { |count, key| phrase(count, key, conversion) }.join(subunit_separator)
    end

    def amount_parts(whole, part, unit, subunit, options)
      parts = []
      parts << [whole, unit] unless whole.zero? && part.positive? && options[:remove_zero]
      parts << [part, subunit] if part.positive? || options[:zero_subunit]
      parts
    end

    def split(number, places)
      raise UnsupportedOptionError, 'subunit needs precision: of at least 1' if places.zero?

      value = Rational(number.to_s).abs.round(places, half: :even)
      whole = value.to_i
      [whole, ((value - whole) * (10**places)).to_i]
    end

    # The unit and subunit keys, or nil, and the options without them.
    def extract(options)
      names = options.keys.select { |option| option.respond_to?(:to_sym) }.to_h { |option| [option.to_sym, option] }
      unit = options[names[:unit]]
      subunit = options[names[:subunit]]
      check!(unit, subunit, options)
      [unit, subunit, options.except(names[:unit], names[:subunit])]
    end

    def check!(unit, subunit, options)
      raise UnsupportedOptionError, 'subunit needs a unit' if subunit && unit.nil?
      raise UnsupportedOptionError, 'zero_subunit needs a subunit' if options[:zero_subunit] && subunit.nil?
    end

    def lookup(unit, key)
      locale = ::I18n.locale
      raise UnsupportedOptionError, "unit #{unit.inspect} has no translation for locale #{locale.inspect} (expected #{key})" unless ::I18n.exists?(key, locale)

      ::I18n.t(key, locale:)
    end

    # The unit's gender, where the language has genders and the call does not choose one.
    def with_gender(options, entry)
      gender = entry[:gender] if entry.is_a?(Hash)
      return options if gender.nil? || options.key?(:gender) || !gender?

      OptionsValidation.validate!(options.merge(gender:))
    end

    def gender?
      OptionsValidation.supported_options(I18n.local_language).key?(:gender)
    end

    # An ordinal describes one thing (the twenty-first dollar), so it takes the singular form.
    def count(number, options)
      options[:ordinal] ? 1 : number.abs
    end

    def form(unit, key, count)
      ::I18n.t(key, count:)
    rescue ::I18n::InvalidPluralizationData
      raise UnsupportedOptionError, "unit #{unit.inspect} has no form for count #{count} or :other in locale #{::I18n.locale.inspect} (#{key})"
    end

    # The unit form after a decimal, which the plural rules for whole numbers don't cover.
    def decimal_form(unit, key, entry, number)
      return entry unless entry.is_a?(Hash)

      entry.fetch(decimal_category(number)) do
        entry.fetch(:other) { raise UnsupportedOptionError, "unit #{unit.inspect} has no form for #{number} or :other in locale #{::I18n.locale.inspect} (#{key})" }
      end
    end

    def decimal_category(number)
      SINGULAR_BELOW_TWO.include?(I18n.local_language) && number.abs < 2 ? :one : :other
    end

    def join(words, form)
      [words, form].reject(&:empty?).join(separator)
    end

    def separator
      UNSPACED.include?(I18n.local_language) ? '' : ' '
    end

    # The word between a unit and its subunit, from the locale ("and" in English), or a plain separator.
    def subunit_separator
      word = ::I18n.t('numbers.subunit_separator', locale: I18n.local_language, default: '')
      word.empty? ? separator : " #{word} "
    end
  end
end
