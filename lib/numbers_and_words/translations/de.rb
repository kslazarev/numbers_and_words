# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::De.
    class De < Base
      include NumbersAndWords::Translations::Families::Base

      DEFAULT_POSTFIX = :combine

      def ones(number, options = {})
        t([options[:prefix], :ones, options[:postfix] || DEFAULT_POSTFIX].join('.'))[number]
      end
    end
  end
end
