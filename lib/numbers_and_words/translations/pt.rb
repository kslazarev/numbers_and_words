# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Pt < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::PortugueseFractions

      def ones(number, options = {})
        return if options[:is_one_thousand]

        options[:gender] == :female ? t('female.ones')[number] : super
      end

      def tens_with_ones(numbers, options = {})
        super(numbers, options.merge(separator: " #{union} "))
      end

      def hundreds(number, options = {})
        return t(:one_hundred) if options[:is_one_hundred]

        hundreds = t(options[:gender] == :female ? 'female.hundreds' : :hundreds)[number]
        return hundreds if options[:is_hundred]

        [hundreds, union].join(' ')
      end
    end
  end
end
