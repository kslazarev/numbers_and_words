# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class El < Base
      def ones(digit, gender = :neuter)
        t(:ones)[gender][digit]
      end

      def zero
        ones(0)
      end

      def teens(number, gender = :neuter)
        t(:teens)[gender][number - 10]
      end

      def tens(digit)
        t(:tens)[digit]
      end

      def hundreds(digit, gender = :neuter)
        t(:hundreds)[gender][digit]
      end

      def mega(capacity, count = 1)
        count == 1 ? t(:mega)[capacity] : t(:mega_plural)[capacity]
      end

      def micro_separator
        t(:micro_separator)
      end
    end
  end
end
