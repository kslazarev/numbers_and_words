module NumbersAndWords
  module Translations
    class It < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones numbers, options = {}
        super numbers, :separator => ''
      end

      def hundreds number, options = {}
        [[number], t(:hundreds)].join ' '
      end
    end
  end
end
