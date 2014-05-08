module NumbersAndWords
  module Translations
    class Et < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones numbers, options = {}
        [tens(numbers[1], :alone => false), ones(numbers[0])].join ' '
      end

      def hundreds number, options = {}
        options[:separator] = ''
        super number, options
      end
    end
  end
end
