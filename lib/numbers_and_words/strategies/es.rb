module NumbersAndWords
  module Strategies
    class Es < Base
      include Families::Latin
      include NumbersAndWords::TranslationsHelpers::Es
    end
  end
end
