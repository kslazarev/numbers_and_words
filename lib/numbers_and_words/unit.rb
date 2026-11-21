# frozen_string_literal: true

module NumbersAndWords
  # The unit option: spells a whole number followed by a unit word that the application translates under units.<key>,
  # with one form per plural category of the locale, and optionally the grammatical gender the number agrees with.
  #   ru: { units: { kopeck: { one: копейка, few: копейки, many: копеек, other: копейки, gender: female } } }
  module Unit
    SCOPE = 'units'
    # Locales whose numbers are written without spaces, so the unit follows without one.
    UNSPACED = %i[th zh].freeze
    DECIMALS = 'https://github.com/kslazarev/numbers_and_words/issues/295'

    module_function

    # Converts a number, or any array element, with options that are already validated.
    def convert(number, options)
      unit, options = extract(options)
      return Wrappers.for(number).to_words(options) if unit.nil?

      nominative!(unit, options)
      key = "#{SCOPE}.#{unit}"
      words = Wrappers.for(whole(number, unit)).to_words(with_gender(options, lookup(unit, key)))
      [words, form(unit, key, count(number, options))].reject(&:empty?).join(separator)
    end

    # Unit translations have one form per plural category, all in the nominative.
    def nominative!(unit, options)
      grammatical_case = options[:case]
      return if grammatical_case.nil? || grammatical_case.to_sym == :nominative

      raise UnsupportedOptionError, "unit #{unit.inspect} cannot be used with case: #{grammatical_case.inspect} yet; unit forms are nominative"
    end

    def whole(number, unit)
      return number unless number.is_a?(::Float)

      raise UnsupportedOptionError, "unit #{unit.inspect} cannot be used with decimals such as #{number} yet, see #{DECIMALS}"
    end

    # The unit key, or nil, and the options without it.
    def extract(options)
      name = options.keys.find { |option| option.respond_to?(:to_sym) && option.to_sym == :unit }
      name ? [options[name], options.except(name)] : [nil, options]
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

    def separator
      UNSPACED.include?(I18n.local_language) ? '' : ' '
    end
  end
end
