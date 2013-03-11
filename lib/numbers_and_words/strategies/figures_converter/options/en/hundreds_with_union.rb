module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module En
          class HundredsWithUnion
            attr_accessor :strategy, :options

            def initialize proxy, *args, &block
              @strategy = proxy.strategy
              @options = proxy.options
            end

            def modify_or_leave hundreds
              hundreds += translations.union if active?
              hundreds
            end

            private

            def active?
              @options[:hundreds_with_union]
            end
          end
        end
      end
    end
  end
end