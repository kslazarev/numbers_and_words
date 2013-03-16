module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module En
          class RemoveZero
            attr_accessor :strategy, :options

            def initialize proxy, *args, &block
              @strategy = proxy.strategy
              @options = proxy.options
            end


            def result
              active?
            end

            private

            def active?
              @options[:remove_zero]
            end
          end
        end
      end
    end
  end
end