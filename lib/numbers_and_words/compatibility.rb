# frozen_string_literal: true

module NumbersAndWords
  # Keeps the 1.0 behavior that 2.0 will change, and warns once about each difference.
  module Compatibility
    # Defaults that change in 2.0, by language: option => [1.x default, 2.0 default].
    DECIMALS = { fraction: [true, false] }.freeze
    FRENCH = { fraction: [true, false], spelling: %i[traditional reformed] }.freeze
    DEFAULTS = {
      en: DECIMALS,
      'en-GB': { hundreds_with_union: [false, true] }.freeze,
      fr: FRENCH,
      'fr-CH': FRENCH,
      it: DECIMALS,
      pt: DECIMALS,
      'pt-BR': DECIMALS
    }.freeze

    # Locale codes that 2.0 will reject: se is Northern Sami, and ua and kz are country codes.
    LOCALES = { se: :sv, ua: :uk, kz: :kk }.freeze

    # Options that only change how decimals are read, so integers never warn about them.
    DECIMAL_OPTIONS = %i[fraction].freeze

    @warned = {}
    @mutex = Mutex.new
    @apply_defaults = true

    class << self
      # Specs turn the 1.x defaults off to test the readings 2.0 will default to.
      attr_accessor :apply_defaults
    end

    module_function

    # The options with the 1.x defaults of the current language for those the call does not set.
    def defaults(options, number)
      return options unless Compatibility.apply_defaults

      DEFAULTS.fetch(I18n.local_language, {}).each_with_object(options.dup) do |(name, (legacy, upcoming)), result|
        next if set?(options, name) || skip?(name, number, options)

        result[name] = legacy
        deprecated "The default #{name}: #{legacy.inspect} for #{I18n.local_language.inspect} changes to #{name}: #{upcoming.inspect} in 2.0; " \
                   "pass #{name}: to choose."
      end
    end

    # The bundled language of a locale code that 2.0 will reject, or nil.
    def locale(code)
      language = LOCALES[code]
      return unless language

      warn_once "The locale #{code.inspect} is deprecated and raises NumbersAndWords::UnsupportedLanguageError in 2.0; use #{language.inspect}."
      language
    end

    # An option or value the current language does not support: ignored with a warning, or raised with
    # NumbersAndWords.config.strict_options = true, the default in 2.0.
    def unsupported_option(message)
      raise UnsupportedOptionError, message if NumbersAndWords.config.strict_options

      warn_once "#{message} It is ignored; set NumbersAndWords.config.strict_options = true to raise, the default in 2.0."
    end

    def set?(options, name)
      options.key?(name) || options.key?(name.to_s)
    end

    # fraction: only changes decimals, and units read their subunits in words of their own.
    def skip?(name, number, options)
      DECIMAL_OPTIONS.include?(name) && (!decimal?(number) || options[:unit])
    end

    def decimal?(number)
      number.is_a?(::Array) ? number.any? { |element| decimal?(element) } : number.is_a?(::Float)
    end

    # Default changes are deprecations, shown with Warning[:deprecated] = true or ruby -W:deprecated.
    def deprecated(message)
      warn_once message, category: :deprecated
    end

    # Each warning is shown once per process.
    def warn_once(message, category: nil)
      @mutex.synchronize do
        return if @warned.key?(message)

        @warned[message] = true
      end
      Kernel.warn "numbers_and_words: #{message}", category:
    end

    def reset!
      @mutex.synchronize { @warned.clear }
    end
  end
end
