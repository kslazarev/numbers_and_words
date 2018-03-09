# frozen_string_literal: true

require 'numbers_and_words/strategies/figures_converter/decorators/base'
require 'numbers_and_words/strategies/figures_converter/decorators/en'
require 'numbers_and_words/strategies/figures_converter/decorators/en-GB'
require 'numbers_and_words/strategies/figures_converter/decorators/es'
require 'numbers_and_words/strategies/figures_converter/decorators/fr'
require 'numbers_and_words/strategies/figures_converter/decorators/ru'
require 'numbers_and_words/strategies/figures_converter/decorators/pt-BR'
require 'numbers_and_words/strategies/figures_converter/decorators/hu'
require 'numbers_and_words/strategies/figures_converter/decorators/ua'
require 'numbers_and_words/strategies/figures_converter/decorators/cs'
require 'numbers_and_words/strategies/figures_converter/decorators/vi'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        class << self
          AVAILABLE = %i[integral fractional].freeze

          def factory(strategy, options)
            enabled_decorator(options).new strategy, options
          end

          private

          def enabled_decorator(options)
            decorator_class AVAILABLE.reject { |name| options[name].nil? }.first
          end

          def decorator_class(method_name)
            method_name ? Object.const_get(decorator_class_name(method_name)) : Decorators::Base
          end

          def decorator_class_name(method_name)
            "#{name}::#{I18n.language_class_name}::#{method_name.to_s.split('_').collect(&:capitalize).join}"
          end
        end
      end
    end
  end
end
