# frozen_string_literal: true

require 'numbers_and_words/strategies/figures_converter/languages/families/helpers'
require 'numbers_and_words/strategies/figures_converter/languages/families/base'
require 'numbers_and_words/strategies/figures_converter/languages/base'

require 'numbers_and_words/strategies/figures_converter/languages/cs'
require 'numbers_and_words/strategies/figures_converter/languages/de'
require 'numbers_and_words/strategies/figures_converter/languages/en'
require 'numbers_and_words/strategies/figures_converter/languages/en-GB'
require 'numbers_and_words/strategies/figures_converter/languages/es'
require 'numbers_and_words/strategies/figures_converter/languages/et'
require 'numbers_and_words/strategies/figures_converter/languages/fr'
require 'numbers_and_words/strategies/figures_converter/languages/hu'
require 'numbers_and_words/strategies/figures_converter/languages/it'
require 'numbers_and_words/strategies/figures_converter/languages/ka'
require 'numbers_and_words/strategies/figures_converter/languages/lt'
require 'numbers_and_words/strategies/figures_converter/languages/lv'
require 'numbers_and_words/strategies/figures_converter/languages/nl'
require 'numbers_and_words/strategies/figures_converter/languages/pt-BR'
require 'numbers_and_words/strategies/figures_converter/languages/pt'
require 'numbers_and_words/strategies/figures_converter/languages/se'
require 'numbers_and_words/strategies/figures_converter/languages/tr'
require 'numbers_and_words/strategies/figures_converter/languages/hy'
require 'numbers_and_words/strategies/figures_converter/languages/kz'

require 'numbers_and_words/strategies/figures_converter/languages/families/cyrillic'
require 'numbers_and_words/strategies/figures_converter/languages/ru'
require 'numbers_and_words/strategies/figures_converter/languages/ua'
require 'numbers_and_words/strategies/figures_converter/languages/vi'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class << self
          def factory(strategy)
            Object.const_get("#{name}::#{I18n.language_class_name}").new strategy
          end
        end
      end
    end
  end
end
