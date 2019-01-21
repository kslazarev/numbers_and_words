# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Base
          class Gender
            attr_accessor :strategy, :options

            def initialize(proxy, *_args)
              @strategy = proxy.strategy
              @options = proxy.options
            end

            def result
              active? ? @options[:gender].to_sym : :male
            end

            private

            def active?
              @options[:gender]
            end
          end
        end
      end
    end
  end
end
