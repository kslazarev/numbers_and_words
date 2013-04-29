require 'numbers_and_words/strategies/figures_converter/decorators/base'
require 'numbers_and_words/strategies/figures_converter/decorators/en'
require 'numbers_and_words/strategies/figures_converter/decorators/en_gb'
require 'numbers_and_words/strategies/figures_converter/decorators/ru'
require 'numbers_and_words/strategies/figures_converter/decorators/hu'
require 'numbers_and_words/strategies/figures_converter/decorators/ua'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        class << self
          AVAILABLE = [:integral, :fractional]

          def factory strategy, options
            enabled_decorator(options).new strategy, options
          end

          private

          def enabled_decorator options
            decorator_class AVAILABLE.select { |name| !options[name].nil? }.first
          end

          def decorator_class method_name
            method_name ? decorator_class_name(method_name).constantize : Decorators::Base
          end

          def decorator_class_name method_name
            "#{name}::#{I18n.language_class_name}::#{method_name.to_s.camelcase}"
          end
        end
      end
    end
  end
end