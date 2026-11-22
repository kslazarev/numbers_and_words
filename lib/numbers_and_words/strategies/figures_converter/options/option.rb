# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        # An option a language declares under numbers.supported_options in its locale file. A true or false option
        # gives its value; one with values gives the value as a symbol, or the declared default when it isn't given.
        # A language's own class, such as Options::Pl::Ordinal, extends this one when an option needs checks.
        class Option
          attr_reader :strategy, :options

          def initialize(proxy, *_args, name: nil, default: nil)
            @strategy = proxy.strategy
            @options = proxy.options
            @name = name || OptionsValidation.snake_case(self.class.name.split('::').last)
            @default = default&.to_sym
          end

          def result
            value = @options[@name]
            return @default if value.nil?

            value.respond_to?(:to_sym) ? value.to_sym : value
          end
        end
      end
    end
  end
end
