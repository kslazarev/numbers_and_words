# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Lv.
    class Lv < Base
      include NumbersAndWords::Translations::Families::Latin
    end
  end
end
