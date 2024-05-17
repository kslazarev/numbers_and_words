# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Da < Base
      include NumbersAndWords::Translations::Families::Base

      DEFAULT_POSTFIX = nil

      def ones(number, options = {})
        return t(:common)[number] if options[:gender] == :common
        return t(:neuter)[number] if options[:gender] == :neuter

        t([options[:prefix], :ones, options[:postfix] || DEFAULT_POSTFIX].join('.'))[number]
      end

      def tens(number, _options = {})
        t(:tens)[number]
      end

      def tens_with_ones(numbers, _options = {})
        [ones(numbers[0], { gender: :common }), tens(numbers[1])].join(union)
      end

      def hundreds(number, options = {})
        return t(:one_hundred) if options[:is_one_hundred]
        return t(:hundreds)[number] if options[:is_hundred]

        t(:hundreds)[number]
      end

      def zero(_options = {})
        ones 0
      end
    end
  end
end
