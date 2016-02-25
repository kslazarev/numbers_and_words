module NumbersAndWords
  module Translations
    class Cs < Base
      include NumbersAndWords::Translations::Families::Latin

      def one options = {}
        t(:one)
      end

      def hundreds number, options = {}
        t(:hundreds)[number - 1]
      end
    end
  end
end
