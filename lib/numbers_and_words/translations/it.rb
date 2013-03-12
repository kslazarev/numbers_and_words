module NumbersAndWords
  module Translations
    class It < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones numbers
        super numbers, :separator => ''
      end

      def hundreds number
        [[number], t(:hundreds)].join ' '
      end
    end
  end
end
