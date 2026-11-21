# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Id < Base
      def ones(digit)
        t(:ones)[digit]
      end

      def zero
        ones(0)
      end

      def mega(capacity)
        t(:mega)[capacity]
      end

      def micro_separator
        t(:micro_separator)
      end
    end
  end
end
