# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words are read from the locale file by Strategies::FiguresConverter::Languages::Bg.
    class Bg < Base
      def micro_separator
        t(:micro_separator)
      end

      # "цяло" does not change with the number: "едно цяло", "пет цяло".
      def integral(_number)
        t(:integral)
      end

      # The fraction noun for a number of decimal places: "една десета", "пет десети".
      def fraction(length, number)
        nouns = t(:fractions)[number == 1 ? :one : :many]
        raise Families::Base.decimal_range_error(nouns.size - 1) if length >= nouns.size

        nouns[length]
      end
    end
  end
end
