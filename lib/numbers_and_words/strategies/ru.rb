module NumbersAndWords
  module Strategies
    class Ru < Base
      include Families::Cyrillic
      include NumbersAndWords::TranslationsHelpers::Ru
    end
  end
end
