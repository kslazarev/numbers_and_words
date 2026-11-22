# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::El.
    class El < Base
      def zero
        t(:ones)[:neuter][0]
      end
    end
  end
end
