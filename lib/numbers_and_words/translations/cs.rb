# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Cs < Base
      include NumbersAndWords::Translations::Families::Base
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def zero(options = {})
        ones(0, options)
      end

      def ones(number, options = {})
        t([options[:prefix], :ones, options[:gender]].join('.'))[number]
      end

      def tens(number, options = {})
        t([options[:prefix], :tens, gender_to_use(options)].join('.'))[number]
      end

      def teens(numbers, options = {})
        t([options[:prefix], :teens, gender_to_use(options)].join('.'))[numbers[0]]
      end

      def tens_with_ones(numbers, options = {})
        [tens(numbers[1], options), ones(numbers[0], options)].join(' ')
      end

      def hundreds(number, options = {})
        t([options[:prefix], :hundreds, gender_to_use(options)].join('.'))[number]
      end

      def integral(number, _options = {})
        t(:integral, count: fraction_count(number))
      end

      def micros(capacity, number = nil)
        super(capacity, number && fraction_count(number))
      end

      private

      # After "dvacet jedna", "třicet jedna" etc. the noun takes the genitive plural
      # ("dvacet jedna setin"); only a bare 1 takes the singular.
      def fraction_count(number)
        number != 1 && number % 10 == 1 ? 5 : number
      end

      def ordinal?(options)
        options[:prefix] == :ordinal
      end

      def gender_to_use(options)
        ordinal?(options) ? options[:gender] : nil
      end
    end
  end
end
