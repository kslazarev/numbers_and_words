module NumbersAndWords
  module Translations
    class Es < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones numbers, options = {}
        super numbers, :separator => ' y '
      end

      def hundreds number, options = {}
        [t(:ones)[number], t(:hundreds, :count => number)]
      end
    end
  end
end
