module NumbersAndWords
  module Translations
    class Es < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones numbers
        super numbers, ' y '
      end

      def hundreds number
        [t(:ones)[number], t(:hundreds, :count => number)]
      end
    end
  end
end
