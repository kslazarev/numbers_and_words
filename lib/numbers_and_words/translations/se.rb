module NumbersAndWords
  module Translations
    class Se < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones numbers
        super numbers, '-'
      end
    end
  end
end
