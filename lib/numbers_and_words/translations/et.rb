# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Et < Base
      include NumbersAndWords::Translations::Families::Latin

      def hundreds(number, _options = {})
        super number, separator: ''
      end
    end
  end
end
