# frozen_string_literal: true

module NumbersAndWords
  # The unit option: spells a whole number followed by a unit word that the application translates under units.<key>,
  # with one form per plural category of the locale, and optionally the grammatical gender the number agrees with.
  #   ru: { units: { kopeck: { one: копейка, few: копейки, many: копеек, other: копейки, gender: female } } }
  module Unit
    SCOPE = 'units'

    module_function

    # Converts a number, or any array element, with options that are already validated.
    def convert(number, options)
      unit, subunit, options = extract(cardinal_decimal(number, options))
      return Wrappers.for(number).to_words(options) if unit.nil?

      nominative!(unit, options)
      subunit ? Amount.words(number, unit, subunit, options) : phrase(number, unit, options)
    end

    # A number followed by its unit: "twenty-one dollars", "one point five dollars".
    def phrase(number, unit, options)
      number = number.to_i if number.is_a?(::Float) && (number % 1).zero?
      key = "#{SCOPE}.#{unit}"
      entry = lookup(unit, key)
      return join(Wrappers::Float.new(number).to_words(options), decimal_form(unit, key, entry, number)) if number.is_a?(::Float)

      Wrappers::Sign.words(number, options) { |count| whole_phrase(count, unit, entry, options) }
    end

    # A whole number, at least zero, and its unit, in the form and order the language puts them in. A count that
    # repeats its unit (see Order.repeated) is the rest of the count with its unit, then the unit again in the form
    # of the last digits, joined like a subunit (Arabic مائة دينار ودينار).
    def whole_phrase(count, unit, entry, options)
      repeated = Order.repeated(count) unless options[:ordinal]
      return repeated_phrase(count, repeated, unit, entry, options) if repeated

      gender = entry[:gender] if entry.is_a?(Hash)
      number_options = Apocope.apply(with_gender(options, entry))
      words = Wrappers::Integer.new(count).to_words(number_options)
      words = BeforeNoun.apply(words, number_options[:gender] || gender) unless options[:ordinal]
      Order.phrase(count, words, whole_form(unit, "#{SCOPE}.#{unit}", entry, count, options), options)
    end

    def repeated_phrase(count, repeated, unit, entry, options)
      head = whole_phrase(count - repeated, unit, entry, options)
      "#{head}#{Amount.subunit_separator}#{whole_form(unit, "#{SCOPE}.#{unit}", entry, repeated, options)}"
    end

    # Decimals keep the cardinal form: ordinal: true applies to whole numbers only.
    def cardinal_decimal(number, options)
      return options unless number.is_a?(::Float)

      options.reject { |name, _value| name.respond_to?(:to_sym) && name.to_sym == :ordinal }
    end

    # The unit form after a whole number, after a preposition where the number ends in a scale noun (de reais).
    def whole_form(unit, key, entry, number, options)
      zero_form = zero_form(entry, number)
      key = "#{key}.#{zero_form}" if zero_form
      form = form(unit, key, count(number, options))
      options[:ordinal] ? form : ScalePreposition.apply(form, number, entry)
    end

    # The form numbers.unit_after_zero gives a unit after zero, such as the French singular ("zéro euro"), where
    # the unit has that form and no zero form of its own.
    def zero_form(entry, number)
      return unless number.zero? && entry.is_a?(Hash) && !entry.key?(:zero)

      form = I18n.t('numbers.unit_after_zero', default: nil)&.to_sym
      form if entry.key?(form)
    end

    # Unit translations have one form per plural category, all in the nominative.
    def nominative!(unit, options)
      grammatical_case = options[:case]
      return if grammatical_case.nil? || grammatical_case.to_sym == :nominative

      raise UnsupportedOptionError, "The unit #{unit.inspect} cannot be used with case: #{grammatical_case.inspect} yet, as unit forms are nominative."
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
      raise UnsupportedOptionError, 'The subunit option needs a unit.' if subunit && unit.nil?
      raise UnsupportedOptionError, 'The zero_subunit option needs a subunit.' if options[:zero_subunit] && subunit.nil?
    end

    def lookup(unit, key)
      locale = ::I18n.locale
      raise UnsupportedOptionError, "The unit #{unit.inspect} has no translation in #{locale.inspect}, expected at #{key}." unless ::I18n.exists?(key, locale)

      I18n.t(key, locale:)
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
      I18n.t(key, count:)
    rescue ::I18n::InvalidPluralizationData
      raise UnsupportedOptionError, "The unit #{unit.inspect} has no form for count #{count} or :other in #{::I18n.locale.inspect}, at #{key}."
    end

    # The unit form after a decimal, which the plural rules for whole numbers don't cover.
    def decimal_form(unit, key, entry, number)
      return entry unless entry.is_a?(Hash)

      entry.fetch(decimal_category(number)) do
        entry.fetch(:other) { raise UnsupportedOptionError, "The unit #{unit.inspect} has no form for #{number} or :other in #{::I18n.locale.inspect}, at #{key}." }
      end
    end

    # After a decimal a unit takes its other form (1.5 dollars, 1,5 рубля), or the form under
    # numbers.unit_after_decimal: form: few in Romanian ("virgulă cinci lei"), and below_two: one in French and
    # Portuguese ("1,5 euro").
    def decimal_category(number)
      after = I18n.t('numbers.unit_after_decimal', default: {})
      form = after[:below_two] if number.abs < 2
      (form || after[:form] || :other).to_sym
    end

    def join(words, form)
      [words, form].reject(&:empty?).join(separator)
    end

    def separator
      I18n.word_separator
    end
  end
end

require 'numbers_and_words/unit/amount'
require 'numbers_and_words/unit/scale_preposition'
require 'numbers_and_words/unit/apocope'
require 'numbers_and_words/unit/before_noun'
require 'numbers_and_words/unit/order'
