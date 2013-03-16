require 'numbers_and_words/strategies/figures_converter/languages/families/helpers'
require 'numbers_and_words/strategies/figures_converter/languages/families/base'

require 'numbers_and_words/strategies/figures_converter/languages/base'

require 'numbers_and_words/strategies/figures_converter/languages/families/latin'

require 'numbers_and_words/strategies/figures_converter/languages/en'
require 'numbers_and_words/strategies/figures_converter/languages/fr'
require 'numbers_and_words/strategies/figures_converter/languages/hu'
require 'numbers_and_words/strategies/figures_converter/languages/se'
require 'numbers_and_words/strategies/figures_converter/languages/it'
require 'numbers_and_words/strategies/figures_converter/languages/nl'
require 'numbers_and_words/strategies/figures_converter/languages/tr'
require 'numbers_and_words/strategies/figures_converter/languages/es'

require 'numbers_and_words/strategies/figures_converter/languages/families/cyrillic'

require 'numbers_and_words/strategies/figures_converter/languages/ru'
require 'numbers_and_words/strategies/figures_converter/languages/ua'


module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class << self
          def factory strategy
            "#{name}::#{language_class_name}".constantize.new strategy
          end

          def language_class_name
            ::I18n.locale.to_s.titleize.gsub ' ', '::'
          end
        end
      end
    end
  end
end