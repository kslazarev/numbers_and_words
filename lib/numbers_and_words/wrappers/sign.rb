# frozen_string_literal: true

module NumbersAndWords
  module Wrappers
    # A negative number reads as the locale's minus word followed by its absolute value ("minus five"), joined
    # without a space in languages written without spaces ("负五"). Negative numbers have no ordinal.
    module Sign
      module_function

      def words(number, options)
        return yield(number) unless number.negative?
        raise UnsupportedNumberError, "Negative numbers have no ordinal: #{number}." if ordinal?(options)

        prefix(yield(-number))
      end

      def prefix(words)
        language = I18n.local_language
        [I18n.t('numbers.minus', locale: language), words].join(I18n.word_separator(language))
      end

      def ordinal?(options)
        options.any? { |name, value| value && name.respond_to?(:to_sym) && name.to_sym == :ordinal }
      end
    end
  end
end
