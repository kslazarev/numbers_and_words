# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Hy < Base
      include NumbersAndWords::Translations::Families::Latin

      def tens_with_ones(numbers, options = {})
        options[:separator] ||= ''
        super
      end

      def hundreds(number, _options = {})
        parts = [t(:hundreds)]
        parts.unshift(t(:ones)[number]) if number > 1

        parts.join(' ')
      end
    end
  end
end
