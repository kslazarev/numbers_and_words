require 'numbers_and_words/strategies/array_joiner/languages'

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      class Base

        attr_accessor :options, :elements, :translations, :language

        def initialize elements, options = {}
          @elements = elements
          @options = options
          @translations = Translations.factory
          @language = Languages.factory(self)
        end

        def run
          language.join
        end
      end
    end
  end
end
