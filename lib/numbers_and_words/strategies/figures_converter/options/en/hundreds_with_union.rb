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
              hundreds = "#{hundreds} #{translations.union}" if active? && !round_hundred?
              hundreds
            end

            private

            def active?
              @options[:hundreds_with_union]
            end

            def round_hundred?
              @strategy.language.figures.round_hundred?
            end

            def translations
              @strategy.translations
            end
          end
        end
      end
    end
  end
end