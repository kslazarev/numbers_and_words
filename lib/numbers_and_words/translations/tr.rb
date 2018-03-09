# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Tr < Base
      include NumbersAndWords::Translations::Families::Latin

      def hundreds(number, options = {})
        if number == 1
          [t([options[:prefix], :hundreds].join('.'))].join options[:separator] || ' '
        else
          [t(:ones)[number], t([options[:prefix], :hundreds].join('.'))].join options[:separator] || ' '
        end
      end
    end
  end
end
