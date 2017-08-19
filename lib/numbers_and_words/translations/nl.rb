module NumbersAndWords
  module Translations
    class Nl < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones(numbers, _options = {})
        [ones(numbers[0]), tens(numbers[1])].join(union)
      end

      def hundreds(number, _options = {})
        return t(:hundreds) if number == 1
        super number, separator: ''
      end
    end
  end
end
