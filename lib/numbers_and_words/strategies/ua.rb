module NumbersAndWords
  module Strategies
    class Ua < Base
      include Families::Cyrillic
      include NumbersAndWords::TranslationsHelpers::Ua
    end
  end
end
