# frozen_string_literal: true

require 'numbers_and_words/i18n'
require 'numbers_and_words/strategies/figures_converter/languages/base'
require 'numbers_and_words/strategies/figures_converter/languages/ordinals'
require 'numbers_and_words/strategies/figures_converter/languages/rule_sets'

require 'numbers_and_words/strategies/figures_converter/languages/cs'
require 'numbers_and_words/strategies/figures_converter/languages/en'
require 'numbers_and_words/strategies/figures_converter/languages/en-GB'
require 'numbers_and_words/strategies/figures_converter/languages/es'
require 'numbers_and_words/strategies/figures_converter/languages/fr'
require 'numbers_and_words/strategies/figures_converter/languages/fr-CH'
require 'numbers_and_words/strategies/figures_converter/languages/ka'
require 'numbers_and_words/strategies/figures_converter/languages/nl'
require 'numbers_and_words/strategies/figures_converter/languages/pt-BR'
require 'numbers_and_words/strategies/figures_converter/languages/pt'
require 'numbers_and_words/strategies/figures_converter/languages/da'

require 'numbers_and_words/strategies/figures_converter/languages/vi'
require 'numbers_and_words/strategies/figures_converter/languages/myriad'
require 'numbers_and_words/strategies/figures_converter/languages/zh'
require 'numbers_and_words/strategies/figures_converter/languages/ja'
require 'numbers_and_words/strategies/figures_converter/languages/ko'
require 'numbers_and_words/strategies/figures_converter/languages/he'
require 'numbers_and_words/strategies/figures_converter/languages/nb'
require 'numbers_and_words/strategies/figures_converter/languages/ar'
require 'numbers_and_words/strategies/figures_converter/languages/pl'
require 'numbers_and_words/strategies/figures_converter/languages/ro'
require 'numbers_and_words/strategies/figures_converter/languages/el'

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # A language with nothing of its own beyond its locale file's rule sets is a class that only includes
        # RuleSets, defined here (Languages::Sv).
        I18n.define_classes(self) { Class.new(Base) { include RuleSets } }

        class << self
          def factory(strategy)
            Object.const_get("#{name}::#{I18n.language_class_name}").new strategy
          end
        end
      end
    end
  end
end
