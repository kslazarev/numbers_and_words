module NumbersAndWords
  module Translations
    class Lt < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens number, options = {}
        super(number)
      end

      def tens_with_ones numbers, options = {}
        [tens(numbers[1], :alone => false), ones(numbers[0])].join ' '
      end


      def hundreds number, options = {}
        options[:is_hundred] = false if options[:is_hundred].nil?
        options[:is_hundred] ? t(:one_hundred) : t(:hundreds)[number - 1]
      end
    end
  end
end
