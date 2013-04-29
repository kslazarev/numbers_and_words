require 'numbers_and_words/strategies/figures_converter/options/en'
require 'numbers_and_words/strategies/figures_converter/options/en_gb'
require 'numbers_and_words/strategies/figures_converter/options/ru'
require 'numbers_and_words/strategies/figures_converter/options/ua'
require 'numbers_and_words/strategies/figures_converter/options/hu'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        class Proxy
          attr_accessor :strategy, :options

          def initialize strategy, options
            @strategy = strategy
            @options = options
          end

          def method_missing method_name, *args, &block
            proxy_class_name(method_name).constantize.new self, args, block
          rescue NameError
            return nil
          end

          private

          def proxy_class_name method_name
            "#{module_name}::#{I18n.language_class_name}::#{method_name.to_s.camelcase}"
          end

          def module_name
            self.class.name.split('::')[0..-2].join '::'
          end
        end
      end
    end
  end
end