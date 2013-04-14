module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        class Base
          include Languages::Families::Base

          attr_accessor :strategy, :elements, :translations, :strings, :options

          def initialize strategy
            @strategy = strategy
            @elements = strategy.elements
            @translations = strategy.translations
            @options = strategy.options
          end

          def join
            elements_logic
          end
        end
      end
    end
  end
end
