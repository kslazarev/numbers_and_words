# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Ar < Base
      def ones(digit)
        t(:ones)[digit]
      end

      def teens(digit)
        t(:teens)[digit]
      end

      def tens(digit)
        t(:tens)[digit]
      end

      def hundreds(digit)
        t(:hundreds)[digit]
      end

      # The forms of the scale word 1000**(capacity): singular, dual, plural and accusative.
      def scale(capacity, form)
        t(:scales)[capacity - 1][form]
      end

      def scales
        t(:scales).size
      end
    end
  end
end
