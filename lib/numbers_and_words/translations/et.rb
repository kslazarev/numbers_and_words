module NumbersAndWords
  module Translations
    class Et < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones numbers, options = {}
        if numbers[1] == 1
          [ones(numbers[0]), tens(numbers[1], :alone => false)].join ''
        else
          [tens(numbers[1], :alone => false), ones(numbers[0])].join ' '
        end
      end

      def hundreds number, options = {}
        options[:separator] = ''
        super number, options
      end
    end
  end
end
