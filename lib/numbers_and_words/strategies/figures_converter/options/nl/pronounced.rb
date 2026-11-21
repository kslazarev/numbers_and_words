# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Nl
          # pronounced: true reads four-digit numbers with a nonzero hundreds digit as tens of hundreds,
          # as they are usually spoken ("negentienhonderd tien").
          class Pronounced
            attr_accessor :strategy, :options

            def initialize(proxy, *_args)
              @strategy = proxy.strategy
              @options = proxy.options
            end

            def result
              @options[:pronounced]
            end
          end
        end
      end
    end
  end
end
