# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words are read from the locale file by Strategies::FiguresConverter::Languages::Sk.
    class Sk < Base
      # "nula celých", "jedna celá", "dve celé", "päť celých".
      def integral(number)
        t(:integral)[form(number)]
      end

      # The fraction noun for a number of decimal places: "jedna desatina", "dve desatiny", "päť desatín".
      def fraction(length, number)
        nouns = t(:fractions)[form(number)]
        raise Families::Base.decimal_range_error(nouns.size - 1) if length >= nouns.size

        nouns[length]
      end

      # Nouns take the singular after 1, the nominative plural after 2 to 4 and the genitive plural otherwise,
      # also after compounds such as 21 or 22.
      def form(number)
        return :one if number == 1

        (2..4).cover?(number) ? :few : :many
      end
    end
  end
end
