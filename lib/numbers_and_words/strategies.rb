require 'numbers_and_words/strategies/figures_converter'
require 'numbers_and_words/strategies/array_joiner'
#require 'numbers_and_words/strategies/extensions/options/fractional'
#require 'numbers_and_words/strategies/extensions/options/integral'

#require 'numbers_and_words/strategies/base'
#require 'numbers_and_words/strategies/families/base'
#require 'numbers_and_words/strategies/families/cyrillic'
#require 'numbers_and_words/strategies/families/latin'

#require 'numbers_and_words/strategies/ru'
#require 'numbers_and_words/strategies/en'
#require 'numbers_and_words/strategies/ua'
#require 'numbers_and_words/strategies/tr'
#require 'numbers_and_words/strategies/fr'
#require 'numbers_and_words/strategies/nl'
#require 'numbers_and_words/strategies/it'
#require 'numbers_and_words/strategies/hu'
#require 'numbers_and_words/strategies/se'
#require 'numbers_and_words/strategies/es'
#

module NumbersAndWords
  module Strategies
    ALL = [FiguresConverter, ArrayJoiner]

    class << self
      def figures_converter
        FiguresConverter::Base
      end

      def array_joiner
        ArrayJoiner::Base
      end
    end
  end
end