# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Pt < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones(numbers, _options = {})
        super numbers, separator: " #{union} "
      end

      def hundreds(number, options = {})
        return t(:one_hundred) if options[:is_one_hundred]
        return t(:hundreds)[number] if options[:is_hundred]

        [t(:hundreds)[number], union].join(' ')
      end
    end
  end
end
