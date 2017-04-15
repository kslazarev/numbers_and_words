module NumbersAndWords
  module Translations
    class En < Base
      include NumbersAndWords::Translations::Families::Latin
      include NumbersAndWords::Translations::Extensions::FractionSignificance
    end
    class EnUs < En
    end
  end
end
