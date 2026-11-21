# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Ko < Base
      def ones(digit)
        t(:ones)[digit]
      end

      def place(power)
        t(:places)[power]
      end

      def scale(index)
        t(:scales)[index] || raise(RangeError, "10^#{index * 4} is beyond the largest Korean scale")
      end

      def micro_separator
        t(:micro_separator)
      end
    end
  end
end
