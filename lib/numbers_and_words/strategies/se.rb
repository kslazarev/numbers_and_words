module NumbersAndWords
  module Strategies
    class Se < Base
      include Families::Latin
      include NumbersAndWords::TranslationsHelpers::Se
    end
  end
end
