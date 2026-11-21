# frozen_string_literal: true

module NumbersAndWords
  class Config
    attr_reader :locales

    # NumbersAndWords.config applies each setting as soon as it is assigned.
    # The config that configure yields only collects settings until its block completes.
    def initialize(apply: false)
      @apply = apply
      @locales = nil
    end

    # Validates every locale before changing anything, so an unsupported locale leaves the configuration as it was.
    def locales=(locales)
      normalized = locales.nil? ? nil : Array(locales).map { |locale| normalize_locale(locale) }.uniq.freeze
      @locales = normalized
      I18n::Initialization.load_locales(normalized) if @apply
    end

    private

    def normalize_locale(locale)
      raise ArgumentError, "Unsupported locale: #{locale.inspect}" unless locale.is_a?(String) || locale.is_a?(Symbol)

      I18n.normalize_language(locale.to_sym)
    rescue RuntimeError
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
      candidate.locales = config.locales
      yield candidate
      config.locales = candidate.locales
    end
  end
end
