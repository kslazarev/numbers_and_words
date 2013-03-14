module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        class Base
          def initialize strategy, options
            @strategy = strategy
            @options = options
          end

          def run
            yield
          end
        end
      end
    end
  end
end