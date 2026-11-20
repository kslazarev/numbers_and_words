# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Se < Base
      include NumbersAndWords::Translations::Families::Latin

      def ones(number, options = {})
        return t(:common_one) if number == 1 && options[:common]

        super
      end

      def hundreds(number, _options = {})
        super(number, separator: '')
      end

      def tens_with_ones(numbers, options = {})
        super(numbers, options.merge(separator: ''))
      end
    end
  end
end
