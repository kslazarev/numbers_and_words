# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Hu.
    class Hu < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance
    end
  end
end
