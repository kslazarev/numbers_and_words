# frozen_string_literal: true

require 'numbers_and_words/strategies/array_joiner/languages/families/base'
require 'numbers_and_words/strategies/array_joiner/languages/families/indian'

require 'numbers_and_words/strategies/array_joiner/languages/base'
require 'numbers_and_words/strategies/array_joiner/languages/decimal_point'

require 'numbers_and_words/strategies/array_joiner/languages/en'
require 'numbers_and_words/strategies/array_joiner/languages/en-GB'
require 'numbers_and_words/strategies/array_joiner/languages/es'
require 'numbers_and_words/strategies/array_joiner/languages/fr'
require 'numbers_and_words/strategies/array_joiner/languages/fr-CH'
require 'numbers_and_words/strategies/array_joiner/languages/hu'
require 'numbers_and_words/strategies/array_joiner/languages/it'
require 'numbers_and_words/strategies/array_joiner/languages/ru'
require 'numbers_and_words/strategies/array_joiner/languages/uk'
require 'numbers_and_words/strategies/array_joiner/languages/pt-BR'
require 'numbers_and_words/strategies/array_joiner/languages/pt'
require 'numbers_and_words/strategies/array_joiner/languages/cs'
require 'numbers_and_words/strategies/array_joiner/languages/vi'
require 'numbers_and_words/strategies/array_joiner/languages/th'
require 'numbers_and_words/strategies/array_joiner/languages/zh'
require 'numbers_and_words/strategies/array_joiner/languages/hi'
require 'numbers_and_words/strategies/array_joiner/languages/bn'
require 'numbers_and_words/strategies/array_joiner/languages/ur'
require 'numbers_and_words/strategies/array_joiner/languages/he'
require 'numbers_and_words/strategies/array_joiner/languages/pl'
require 'numbers_and_words/strategies/array_joiner/languages/nl'
require 'numbers_and_words/strategies/array_joiner/languages/de'

module NumbersAndWords
  module Strategies
    module ArrayJoiner
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
