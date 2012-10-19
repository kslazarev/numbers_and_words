module NumbersAndWords
  module Strategies
    class Tr < Base
      include Families::Latin
      include NumbersAndWords::TranslationsHelpers::Tr
    end
  end
end
