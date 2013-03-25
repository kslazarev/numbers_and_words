module NumbersAndWords
  module Translations
    class Tr < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones numbers, options = {}
        super numbers, :separator => ' '
      end
    end
  end
end
