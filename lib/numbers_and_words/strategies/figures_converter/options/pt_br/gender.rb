module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module PtBr
          class Gender
            attr_accessor :strategy, :options

            def initialize proxy, *args, &block
              @strategy = proxy.strategy
              @options = proxy.options
            end

            def result
              gender = active? ? @options[:gender].to_sym : :male
              [:male, :female].include?(gender) ? gender : :male
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
