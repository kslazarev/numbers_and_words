# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words of whole numbers are read from the locale file by Strategies::FiguresConverter::Languages::Cs.
    class Cs < Base
      def integral(number, _options = {})
        t(:integral, count: fraction_count(number))
      end

      def micros(capacity, number = nil)
        super(capacity, number && fraction_count(number))
      end

      private

      # After "dvacet jedna", "třicet jedna" etc. the noun takes the genitive plural
      # ("dvacet jedna setin"); only a bare 1 takes the singular.
      def fraction_count(number)
        number != 1 && number % 10 == 1 ? 5 : number
      end
    end
  end
end
