# frozen_string_literal: true

module NumbersAndWords
  module Translations
    # The words are read from the locale file by Strategies::FiguresConverter::Languages::Fi.
    class Fi < Base
      def micro_separator
        t(:micro_separator)
      end
    end
  end
end
