# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Az < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      # "yüz" rather than "bir yüz".
      def hundreds(number, options = {})
        words = [t([options[:prefix], :hundreds].join('.'))]
        words.unshift(t(:ones)[number]) unless number == 1
        words.join options[:separator] || ' '
      end
    end
  end
end
