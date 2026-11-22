# frozen_string_literal: true

require 'numbers_and_words/strategies/figures_converter/decorators/base'
require 'numbers_and_words/strategies/figures_converter/decorators/decimal_point'
require 'numbers_and_words/strategies/figures_converter/decorators/indian'
require 'numbers_and_words/strategies/figures_converter/decorators/az/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/bg/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/bg/integral'
require 'numbers_and_words/strategies/figures_converter/decorators/cs/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/cs/integral'
require 'numbers_and_words/strategies/figures_converter/decorators/de/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/el/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/en/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/es/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/fi/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/fr/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/he/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/hu/base'
require 'numbers_and_words/strategies/figures_converter/decorators/hu/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/hu/integral'
require 'numbers_and_words/strategies/figures_converter/decorators/id/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/it/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/ja/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/ko/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/nb/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/nl/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/nl/integral'
require 'numbers_and_words/strategies/figures_converter/decorators/pl/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/pt-BR/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/pt-BR/integral'
require 'numbers_and_words/strategies/figures_converter/decorators/ro/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/ru/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/ru/integral'
require 'numbers_and_words/strategies/figures_converter/decorators/sk/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/sk/integral'
require 'numbers_and_words/strategies/figures_converter/decorators/th/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/uk/fractional'
require 'numbers_and_words/strategies/figures_converter/decorators/uk/integral'
require 'numbers_and_words/strategies/figures_converter/decorators/zh/fractional'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        # Languages that read decimals with the decorators of another language, or of a family, where they have
        # none of their own.
        SHARED = { EnGb: :En, FrCh: :Fr, Pt: :PtBr, Pl: :Cs, Ms: :Id, Hi: :Indian, Bn: :Indian, Ur: :Indian }.freeze
        # Languages that read decimals without decorators.
        PLAIN = %i[Vi].freeze

        class << self
          AVAILABLE = %i[integral fractional].freeze

          def factory(strategy, options)
            enabled_decorator(options).new strategy, options
          end

          # Whether a language, by its class name (PtBr), reads decimals.
          def decimals?(language)
            !own_and_shared(language.to_sym).empty? || PLAIN.include?(language.to_sym)
          end

          private

          def enabled_decorator(options)
            decorator_class AVAILABLE.reject { |name| options[name].nil? }.first
          end

          # The language's decorator, or the shared one, or Base, which leaves the words as they are.
          def decorator_class(method_name)
            return Decorators::Base unless method_name

            name = method_name.to_s.capitalize
            language_decorators.find { |decorators| decorators.const_defined?(name, false) }&.const_get(name, false) || Decorators::Base
          end

          # The decorators of the current language and those it shares; a language without decimals has none.
          def language_decorators
            language = I18n.language_class_name
            raise UnsupportedNumberError, "decimals are not supported in #{::I18n.locale.inspect}" unless decimals?(language)

            own_and_shared(language.to_sym)
          end

          def own_and_shared(language)
            [language, SHARED[language]].compact.select { |name| const_defined?(name, false) }.map { |name| const_get(name, false) }
          end
        end
      end
    end
  end
end
