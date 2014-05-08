module NumbersAndWords
  module Translations
    class Pt < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens numbers, options = {}
        options[:alone] = true if options[:alone].nil?
        options[:alone] ? super(numbers) : "#{t(:union)} " + super(numbers)
      end

      def tens_with_ones numbers, options = {}
        [tens(numbers[1]), " #{t(:union)} ", ones(numbers[0])].join
      end

      def hundreds number, options = {}
        return t(:one_hundred) if options[:is_one_hundred]
        options[:is_hundred] ? t(:hundreds)[number - 1] : t(:hundreds)[number - 1] + ' e'
      end

      def megs capacity, options = {}
        options[:is_one] = false if options[:is_one].nil?
        options[:is_one] ? t(:mega)[capacity] : t(:megas)[capacity]
      end

    end
  end
end
