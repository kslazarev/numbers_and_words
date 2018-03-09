# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Es < Base
      include NumbersAndWords::Translations::Families::Base
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def zero(_options = {})
        t(%i[ones male].join('.'))[0]
      end

      def ones(number, options = {})
        return if options[:is_one_thousand]
        return t(%i[ones apocopated].join('.')) if number == 1 &&
                                                   options[:is_apocopated]
        t([:ones, options[:gender]].join('.'))[number]
      end

      def tens_with_ones(numbers, options = {})
        super numbers, options.merge(separator: " #{union} ")
      end

      def twenties_with_ones(numbers, options = {})
        return t(%i[twenties apocopated].join('.')) if options[:is_apocopated]
        t([:twenties, options[:gender]].join('.'))[numbers[0]]
      end

      def hundreds(number, options = {})
        return t(%i[hundreds apocopated].join('.')) if options[:is_apocopated]
        t([:hundreds, options[:gender]].join('.'))[number]
      end
    end
  end
end
