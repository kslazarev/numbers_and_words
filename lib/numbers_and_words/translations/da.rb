# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Da.
    class Da < Base
      include NumbersAndWords::Translations::Families::Base
    end
  end
end
