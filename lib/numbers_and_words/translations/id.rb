# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Id.
    class Id < Base
      def ones(digit)
        t(:ones)[digit]
      end

      def micro_separator
        t(:micro_separator)
      end
    end
  end
end
