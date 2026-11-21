# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class He < Base
      # Numbers from 0 to 10 in the given grammatical gender.
      def ones(number, gender)
        t(:ones)[gender][number]
      end

      def teens(number, gender)
        t(:teens)[gender][number - 10]
      end

      def tens(digit)
        t(:tens)[digit]
      end

      def hundreds(digit)
        t(:hundreds)[digit]
      end

      # 1,000 to 10,000 in round thousands have their own forms: אלף, אלפיים, שלושת אלפים, ..., עשרת אלפים.
      def thousands(number)
        t(:thousands)[number]
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
