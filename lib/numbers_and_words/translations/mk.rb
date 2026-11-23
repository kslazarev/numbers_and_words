# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Mk.
    class Mk < Base
      # The zero read before a decimal's leading zeros ("нула кома нула пет"); the ones are listed by gender.
      def zero
        t(:ones)[:male][0]
      end
    end
  end
end
