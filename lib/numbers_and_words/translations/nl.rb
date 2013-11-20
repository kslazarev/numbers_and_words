module NumbersAndWords
  module Translations
    class Nl < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones numbers, options = {}
        [ones(numbers[0]), tens(numbers[1], options)].join 'en'
      end

      def hundreds number, options = {}
        1 == number ? t([options[:prefix], :hundreds].join('.')) : [t(:ones)[number], t([options[:prefix], :hundreds].join('.'))].join
      end
    end
  end
end
