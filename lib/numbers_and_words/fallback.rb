# frozen_string_literal: true

module NumbersAndWords
  # Handles the fallback option and setting: what to_words does when the gem cannot convert in the current locale.
  module Fallback
    module_function

    # Yields the options without :fallback in the locale to convert in, or returns the digits for fallback: true.
    def convert(options, digits)
      fallback, options = extract(options || {})
      return yield(options) if !fallback || convertible?
      return digits.call if fallback == true

      ::I18n.with_locale(fallback) { yield(options) }
    end

    # The fallback for this call, from the option or the configuration, and the options without it.
    def extract(options)
      key = options.keys.find { |name| name.respond_to?(:to_sym) && name.to_sym == :fallback }
      return [NumbersAndWords.config.fallback, options] unless key

      [normalize(options[key]), options.except(key)]
    end

    # nil, false, true, or the bundled locale a locale name normalizes to.
    def normalize(fallback)
      return fallback if [nil, false, true].include?(fallback)
      raise UnsupportedOptionError, unsupported(fallback) unless fallback.is_a?(String) || fallback.is_a?(Symbol)

      I18n.normalize_language(fallback.to_sym)
    rescue UnsupportedLanguageError
      raise UnsupportedOptionError, unsupported(fallback)
    end

    def convertible?
      I18n.local_language
      true
    rescue UnsupportedLanguageError
      false
    end

    def unsupported(fallback)
      "The fallback #{fallback.inspect} is not supported; supported: true, false, nil or a bundled locale."
    end
  end
end
