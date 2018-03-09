require 'numbers_and_words/strategies/figures_converter/options/en'
require 'numbers_and_words/strategies/figures_converter/options/en-GB'
require 'numbers_and_words/strategies/figures_converter/options/es'
require 'numbers_and_words/strategies/figures_converter/options/hu'
require 'numbers_and_words/strategies/figures_converter/options/pt-BR'
require 'numbers_and_words/strategies/figures_converter/options/ru'
require 'numbers_and_words/strategies/figures_converter/options/ua'
require 'numbers_and_words/strategies/figures_converter/options/cs'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        class Proxy
          attr_accessor :strategy, :options

          def initialize(strategy, options)
            @strategy = strategy
            @options = options
          end

          def method_missing(method_name, *args, &block)
            Object.const_get(proxy_class_name(method_name)).new self, args, block
          rescue NameError
            nil
          end

          private

          def proxy_class_name(method_name)
            "#{module_name}::#{I18n.language_class_name}::#{method_name.to_s.split('_').collect(&:capitalize).join}"
          end

          def module_name
            self.class.name.split('::')[0..-2].join '::'
          end
        end
      end
    end
  end
end
