# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::PtBr.
    class PtBr < Base
      include NumbersAndWords::Translations::Extensions::PortugueseFractions

      def zero(_options = {})
        t(:ones)[:male][0]
      end
    end
  end
end
