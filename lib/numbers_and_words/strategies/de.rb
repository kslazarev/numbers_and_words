module NumbersAndWords
  module Strategies
    class De < Base
      include Families::Latin
      include NumbersAndWords::TranslationsHelpers::De
    end
  end
end
