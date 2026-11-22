# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::He.
    class He < Base
      def ones(number, gender)
        t(:ones)[gender][number]
      end

      def micro_separator
        t(:micro_separator)
      end
    end
  end
end
