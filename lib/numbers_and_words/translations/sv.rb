# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Sv.
    class Sv < Base
      include NumbersAndWords::Translations::Families::Latin
    end
  end
end
