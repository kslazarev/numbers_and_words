require 'numbers_and_words/strategies/figures_converter/languages'
require 'numbers_and_words/strategies/figures_converter/options'
require 'numbers_and_words/strategies/figures_converter/decorators'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      class Base

        attr_accessor :options, :figures, :translations, :language, :decorator

        def initialize figures, options = {}
          @figures = figures.reverse

          @decorator = Decorators.factory(self, options)
          @options = Options::Proxy.new(self, options)
          @translations = Translations.factory
          @language = Languages.factory(self)
        end

        def run
          around { language.words }
        end

        private

        def around
          decorator.run { yield }
        end
      end
    end
  end
end
