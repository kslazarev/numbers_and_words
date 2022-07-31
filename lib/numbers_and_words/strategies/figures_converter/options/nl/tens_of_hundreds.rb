# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Nl
          class TensOfHundreds
            attr_accessor :strategy, :options

            def initialize(proxy, *_args)
              @strategy = proxy.strategy
              @options = proxy.options
            end

            def result
              active?
            end

            private

            def active?
              @options[:tens_of_hundreds]
            end
          end
        end
      end
    end
  end
end
