module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Ua < Base
          include Families::Cyrillic
          #include NumbersAndWords::Translations::Ua
        end
      end
    end
  end
end
