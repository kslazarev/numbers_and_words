module NumbersAndWords
  module Translations
    class Nl < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones(numbers, _options = {})
        [ones(numbers[0]), tens(numbers[1])].join 'en'
      end

      def hundreds(number, _options = {})
        number == 1 ? t(:hundreds) : [t(:ones)[number], t(:hundreds)].join
      end
    end
  end
end
