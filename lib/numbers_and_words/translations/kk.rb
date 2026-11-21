# frozen_string_literal: true

module NumbersAndWords
  module Translations
    class Kk < Base
      include NumbersAndWords::Translations::Families::Latin

      # "жүз" rather than "бір жүз".
      def hundreds(number, options = {})
        number == 1 ? t(:hundreds) : super
      end
    end
  end
end
