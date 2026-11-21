# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Ro < Base
      # Numbers from 0 to 9 in the given gender; neuter nouns take the masculine one and the feminine two.
      def ones(digit, gender = :male)
        t(:ones)[form(gender, digit)][digit]
      end

      def zero
        ones(0)
      end

      def teens(number, gender = :male)
        t(:teens)[form(gender, number - 10)][number - 10]
      end

      def tens(digit)
        t(:tens)[digit]
      end

      def mega(capacity, count = 1)
        count == 1 ? t(:mega)[capacity] : t(:mega_plural)[capacity]
      end

      def micro_separator
        t(:micro_separator)
      end

      private

      def form(gender, digit)
        return gender if gender != :neuter

        digit == 1 ? :male : :female
      end
    end
  end
end
