# frozen_string_literal: true

module NumbersAndWords
  class Config
    attr_reader :locales

    def locales=(locales)
      @locales = locales.nil? ? nil : Array(locales).map { |locale| normalize_locale(locale) }.uniq.freeze
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
      @config ||= Config.new.freeze
    end

    def configure
      candidate = config.dup
      yield candidate
      @config = candidate.freeze
      I18n::Initialization.load_locales(candidate.locales)
    end
  end
end
