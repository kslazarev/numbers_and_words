module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Ru < Base
          include Families::Base
          include Families::Cyrillic
          #include Extensions::Options::Fractional
          #include Extensions::Options::Integral
          #include NumbersAndWords::Translations::Ru

          #def before_convert
          #  options[:gender] = :female if fractional? || integral?
          #  super
          #end
          #
          def union_elements elements, options = {}
            elements -= [zero]
            super
          end
        end
      end
    end
  end
end
