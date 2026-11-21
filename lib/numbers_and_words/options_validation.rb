# frozen_string_literal: true

module NumbersAndWords
  # Raised when to_words receives an option, or an option value, that the
  # current language does not support.
  class UnsupportedOptionError < ArgumentError; end

  # Checks to_words options against the options the current language supports.
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
      options.each do |name, value|
        check = supported.fetch(name.to_sym) { raise UnsupportedOptionError, unsupported_option(name, language, supported) }
        raise UnsupportedOptionError, unsupported_value(name, value, language, check) unless valid?(check, value)
      end
      options
    end

    # Option classes do not change at runtime, so each language's table is built once.
    def supported_options(language)
      (@supported_options ||= {})[language] ||= language_options(language).merge(GLOBAL).freeze
    end

    def language_options(language)
      namespace = language_namespace(language)
      return {} unless namespace

      namespace.constants.sort.to_h do |constant|
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
