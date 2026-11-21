# frozen_string_literal: true

require 'numbers_and_words/strategies/figures_converter/decorators/base'
require 'numbers_and_words/strategies/figures_converter/decorators/decimal_point'
require 'numbers_and_words/strategies/figures_converter/decorators/en'
require 'numbers_and_words/strategies/figures_converter/decorators/en-GB'
require 'numbers_and_words/strategies/figures_converter/decorators/es'
require 'numbers_and_words/strategies/figures_converter/decorators/fr'
require 'numbers_and_words/strategies/figures_converter/decorators/fr-CH'
require 'numbers_and_words/strategies/figures_converter/decorators/it'
require 'numbers_and_words/strategies/figures_converter/decorators/ru'
require 'numbers_and_words/strategies/figures_converter/decorators/pt-BR'
require 'numbers_and_words/strategies/figures_converter/decorators/pt'
require 'numbers_and_words/strategies/figures_converter/decorators/hu'
require 'numbers_and_words/strategies/figures_converter/decorators/uk'
require 'numbers_and_words/strategies/figures_converter/decorators/cs'
require 'numbers_and_words/strategies/figures_converter/decorators/vi'
require 'numbers_and_words/strategies/figures_converter/decorators/th'
require 'numbers_and_words/strategies/figures_converter/decorators/zh'
require 'numbers_and_words/strategies/figures_converter/decorators/ja'
require 'numbers_and_words/strategies/figures_converter/decorators/ko'
require 'numbers_and_words/strategies/figures_converter/decorators/he'
require 'numbers_and_words/strategies/figures_converter/decorators/indian'
require 'numbers_and_words/strategies/figures_converter/decorators/hi'
require 'numbers_and_words/strategies/figures_converter/decorators/bn'
require 'numbers_and_words/strategies/figures_converter/decorators/ur'
require 'numbers_and_words/strategies/figures_converter/decorators/nb'
require 'numbers_and_words/strategies/figures_converter/decorators/fi'
require 'numbers_and_words/strategies/figures_converter/decorators/bg'
require 'numbers_and_words/strategies/figures_converter/decorators/sk'
require 'numbers_and_words/strategies/figures_converter/decorators/nl'
require 'numbers_and_words/strategies/figures_converter/decorators/pl'
require 'numbers_and_words/strategies/figures_converter/decorators/de'
require 'numbers_and_words/strategies/figures_converter/decorators/id'
require 'numbers_and_words/strategies/figures_converter/decorators/ms'
require 'numbers_and_words/strategies/figures_converter/decorators/ro'
require 'numbers_and_words/strategies/figures_converter/decorators/el'
require 'numbers_and_words/strategies/figures_converter/decorators/az'

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
            method_name ? language_decorators.const_get(method_name.to_s.capitalize, false) : Decorators::Base
          end

          # The decorators of the current language, which a language without decimals does not have.
          def language_decorators
            language = I18n.language_class_name
            return const_get(language, false) if const_defined?(language, false)

            raise UnsupportedNumberError, "decimals are not supported in #{::I18n.locale.inspect}"
          end
        end
      end
    end
  end
end
