module NumbersAndWords
  module Translations
    class En < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      def fraction_separator options = {}
        #type = options[:british] && :british || :us
        t :fraction_separator
      end

      def union
        t :union
      end
    end
  end
end
