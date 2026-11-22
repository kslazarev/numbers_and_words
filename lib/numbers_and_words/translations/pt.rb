# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Pt.
    class Pt < Base
      include NumbersAndWords::Translations::Extensions::PortugueseFractions
    end
  end
end
