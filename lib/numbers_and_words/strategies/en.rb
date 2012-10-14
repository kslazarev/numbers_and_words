module NumbersAndWords
  module Strategies
    class En < Base
      include Families::Latin
      include NumbersAndWords::TranslationsHelpers::En
    end
  end
end
