# frozen_string_literal: true

module NumbersAndWords
  class Config
    SETTINGS = %i[locales fallback strict_options].freeze

    attr_reader :locales, :fallback, :strict_options

    # NumbersAndWords.config applies each setting as soon as it is assigned.
    # The config that configure yields only collects settings until its block completes.
    def initialize(apply: false)
      @apply = apply
      @locales = nil
      @fallback = nil
      @strict_options = false
    end

    # Validates every locale before changing anything, so an unsupported locale leaves the configuration as it was.
    def locales=(locales)
      normalized = locales.nil? ? nil : Array(locales).map { |locale| normalize_locale(locale) }.uniq.freeze
      @locales = normalized
      I18n::Initialization.load_locales(normalized) if @apply
    end

    # What to_words does when the gem cannot convert in the current locale: nil or false raises,
    # a bundled locale converts in that locale, and true returns the number's digits.
    def fallback=(fallback)
      @fallback = Fallback.normalize(fallback)
    end

    # What to_words does with an option or value the current language does not support: false (the default
    # until 2.0) ignores it with a warning, and true raises NumbersAndWords::UnsupportedOptionError.
    def strict_options=(strict)
      raise ArgumentError, "strict_options must be true or false, not #{strict.inspect}" unless [true, false].include?(strict)

      @strict_options = strict
    end

    private

    def normalize_locale(locale)
      raise ArgumentError, "Unsupported locale: #{locale.inspect}" unless locale.is_a?(String) || locale.is_a?(Symbol)

      I18n.normalize_language(locale.to_sym)
    rescue UnsupportedLanguageError
      raise ArgumentError, "Unsupported locale: #{locale.inspect}"
    end
  end

  class << self
    def config
      @config ||= Config.new(apply: true)
    end

    # Collects the settings assigned in the block and applies them only if the block completes.
    def configure
      candidate = Config.new
      Config::SETTINGS.each { |setting| candidate.public_send(:"#{setting}=", config.public_send(setting)) }
      yield candidate
      Config::SETTINGS.each { |setting| config.public_send(:"#{setting}=", candidate.public_send(setting)) }
    end
  end
end
