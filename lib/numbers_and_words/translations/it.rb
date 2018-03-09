# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class It < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones(numbers, _options = {})
        super numbers, separator: ''
      end

      def hundreds(number, _options = {})
        [[number], t(:hundreds)].join ' '
      end
    end
  end
end
