module NumbersAndWords
  module Translations
    class Hu < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def tens_with_ones numbers
        ones, tens = numbers
        [t(:tens_with_ones)[tens], ones(ones)].join ''
      end

      def hundreds number
        [t(:ones)[number], t(:hundreds)].join ''
      end

      def micros capacity, number = nil, separator = ''
        super capacity, nil, separator
      end
    end
  end
end
