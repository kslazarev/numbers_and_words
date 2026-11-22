# frozen_string_literal: true

module NumbersAndWords
  # Raised when to_words receives an option, or an option value, that the
  # current language does not support.
  class UnsupportedOptionError < ArgumentError; end

  # Checks to_words options against the options the current language supports, and returns the supported ones.
  # A language supports the global options plus the option classes it defines
  # under Strategies::FiguresConverter::Options::<Language>.
  module OptionsValidation
    # A rule for values that are not an enumerated list such as gender.
    Rule = Struct.new(:description, :test) do
      def call(value) = test.call(value)
    end

    BOOLEAN = Rule.new('true, false', ->(value) { [true, false].include?(value) })

    GLOBAL = {
      precision: Rule.new('a non-negative integer', ->(value) { value.is_a?(::Integer) && !value.negative? }),
      micro_separator: Rule.new('a string', ->(value) { value.is_a?(::String) }),
      unit: Rule.new('a unit translation key', ->(value) { (value.is_a?(::Symbol) || value.is_a?(::String)) && !value.empty? }),
      subunit: Rule.new('a unit translation key', ->(value) { (value.is_a?(::Symbol) || value.is_a?(::String)) && !value.empty? }),
      zero_subunit: BOOLEAN
    }.freeze

    module_function

    def validate!(options)
      return options if options.nil? || options.empty?

      language = I18n.local_language
      supported = supported_options(language)
      options.select do |name, value|
        check = supported[name.to_sym]
        next unsupported(unsupported_option(name, language, supported)) unless check
        next unsupported(unsupported_value(name, value, language, check)) unless valid?(check, value)

        true
      end
    end

    # Ignores the option with a warning, or raises with NumbersAndWords.config.strict_options = true; false drops it.
    def unsupported(message)
      Compatibility.unsupported_option(message)
      false
    end

    # The options a language supports, built again only when its numbers.supported_options change.
    def supported_options(language)
      declared = declared_options(language)
      cached = (@supported_options ||= {})[language]
      return cached[:options] if cached && cached[:declared].equal?(declared)

      @supported_options[language] = { declared:, options: language_options(language).merge(GLOBAL).freeze }
      @supported_options[language][:options]
    end

    def clear
      @supported_options = {}
    end

    # The options under numbers.supported_options in the language's locale file: true for a true or false option,
    # or the values it takes and its default.
    def declared_options(language)
      ::I18n.t(:supported_options, scope: :numbers, locale: language, default: {})
    end

    # The declared options, with any option class of the language's own, such as a custom extension, as a
    # true or false option or with its VALUES.
    def language_options(language)
      checks = declared_options(language).to_h { |name, declared| [name, declared_check(declared)] }
      class_options(language).each { |name, check| checks[name] ||= check }
      checks.sort.to_h
    end

    def declared_check(declared)
      values = declared.is_a?(::Hash) ? declared[:values] : declared
      values.is_a?(::Array) ? values.map(&:to_sym).freeze : BOOLEAN
    end

    def class_options(language)
      namespace = language_namespace(language)
      return {} unless namespace

      namespace.constants.to_h do |constant|
        option = namespace.const_get(constant)
        [snake_case(constant), option.const_defined?(:VALUES, false) ? option::VALUES : BOOLEAN]
      end
    end

    def language_namespace(language)
      name = language.to_s.split('-').map(&:capitalize).join
      options = Strategies::FiguresConverter::Options
      options.const_get(name, false) if options.const_defined?(name, false)
    end

    def valid?(check, value)
      return check.call(value) if check.is_a?(Rule)

      check.include?(value.respond_to?(:to_sym) ? value.to_sym : value)
    end

    def unsupported_option(name, language, supported)
      "unsupported option #{name.to_sym.inspect} for locale #{language.inspect}; supported: #{supported.keys.sort.map(&:inspect).join(', ')}"
    end

    def unsupported_value(name, value, language, check)
      expected = check.is_a?(Rule) ? check.description : check.map(&:inspect).join(', ')
      "unsupported value #{value.inspect} for option #{name.to_sym.inspect} in locale #{language.inspect}; supported: #{expected}"
    end

    def snake_case(constant)
      constant.to_s.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase.to_sym
    end
  end
end
