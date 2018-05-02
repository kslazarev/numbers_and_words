# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class De < Base
      include NumbersAndWords::Translations::Families::Base
      DEFAULT_POSTFIX = :combine

      def ones(number, options = {})
        t([options[:prefix], :ones, options[:postfix] || DEFAULT_POSTFIX].join('.'))[number]
      end

      def tens_with_ones(numbers, options = {})
        [tens(numbers[1]), ones(numbers[0], options)].reverse.join(union)
      end

      def hundreds(number, _options = {})
        [ones(number), t(:hundreds)].join
      end

      def zero(_options = {})
        ones 0
      end
    end
  end
end
