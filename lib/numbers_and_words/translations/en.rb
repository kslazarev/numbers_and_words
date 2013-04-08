module NumbersAndWords
  module Translations
    class En < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance

      class Gb < En
      end
    end
  end
end
