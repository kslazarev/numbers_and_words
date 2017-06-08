module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module PtBr
          class Ordinal
            def initialize proxy, *args, &block
              @strategy = proxy.strategy
              @options = proxy.options
            end

            def result
              return :ordinal if active?
            end

            private

            def active?
              @options[:ordinal]
            end
          end
        end
      end
    end
  end
end
