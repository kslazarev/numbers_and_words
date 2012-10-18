module NumbersAndWords
  module Strategies
    class It < Base
      include Families::Latin
      include NumbersAndWords::TranslationsHelpers::It
    end
  end
end
