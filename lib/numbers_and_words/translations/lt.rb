# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Lt.
    class Lt < Base
      include NumbersAndWords::Translations::Families::Latin
    end
  end
end
