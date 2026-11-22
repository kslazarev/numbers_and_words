# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Base
          attr_accessor :strategy, :figures, :translations, :options

          def initialize(strategy)
            @strategy = strategy
            @figures = strategy.figures
            @translations = strategy.translations
            @options = strategy.options
          end
        end
      end
    end
  end
end
