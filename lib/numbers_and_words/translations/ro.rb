# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Ro.
    class Ro < Base
      def zero
        t(:ones)[:male][0]
      end

      def micro_separator
        t(:micro_separator)
      end
    end
  end
end
