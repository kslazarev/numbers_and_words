require 'numbers_and_words/strategies/figures_converter/languages'
require 'numbers_and_words/strategies/figures_converter/options'
require 'numbers_and_words/strategies/figures_converter/decorators'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      class Base

        attr_accessor :options, :figures, :translations, :language

        def initialize figures, options = {}
          @figures = figures.reverse
          @options = Options::Proxy.new(self, options)
          @translations = Translations::Base.factory
          @language = Languages::Base.factory(self)
        end

        def run
          around { language.words }
        end

        private

        def around
          before_filter
          result = yield
          after_filter
          result
        end

        def before_filter
          #FiguresConverter::Options::Fractional.new(self, options).fractional?
          #converter = FiguresConverterFractional.new(self, options)
          #converter.run
        end

        def after_filter
        end
      end
    end
  end
end
