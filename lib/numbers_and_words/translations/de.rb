module NumbersAndWords
  module Translations
    class De < Base
      include NumbersAndWords::Translations::Families::Latin
      DEFAULT_POSTFIX = :combine

      def ones number, options = {}
        t([options[:prefix], :ones, options[:postfix] || DEFAULT_POSTFIX].join('.'))[number]
      end

      def tens_with_ones numbers, options = {}
        [tens(numbers[1]), ones(numbers[0], options)].reverse.join 'und'
      end

      def hundreds number, options = {}
        [ones(number), t(:hundreds)].join('')
      end

      def zero options = {}
        ones 0
      end
    end
  end
end