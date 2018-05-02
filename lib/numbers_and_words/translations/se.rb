# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Se < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones(numbers, _options = {})
        super numbers, separator: '-'
      end
    end
  end
end
