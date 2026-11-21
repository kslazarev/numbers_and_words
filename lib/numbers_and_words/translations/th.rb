# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Th < Base
      def ones(digit)
        t(:ones)[digit]
      end

      def tens(digit)
        t(:tens)[digit]
      end

      def place(power)
        t(:places)[power]
      end

      def micro_separator
        t(:micro_separator)
      end
    end
  end
end
