require 'numbers_and_words/strategies/figures_converter/options/en'
require 'numbers_and_words/strategies/figures_converter/options/ru'
require 'numbers_and_words/strategies/figures_converter/options/ua'

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

          def proxy_class_name method_name
            "#{language_class_name}::#{method_name.to_s.camelcase}".modulize(self.class.name)
          end

          def language_class_name
            ::I18n.locale.to_s.titleize.gsub(' ', '::')
          end
        end
      end
    end
  end
end