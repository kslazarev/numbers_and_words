# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Base
          # A true or false option that a language's rule sets read from the options themselves.
          class Flag
            def initialize(proxy, *_args)
              @options = proxy.options
            end

            def result
              @options[OptionsValidation.snake_case(self.class.name.split('::').last)]
            end
          end
        end
      end
    end
  end
end
