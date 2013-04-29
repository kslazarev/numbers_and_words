require 'numbers_and_words/strategies/array_joiner/languages/families/base'

require 'numbers_and_words/strategies/array_joiner/languages/base'

require 'numbers_and_words/strategies/array_joiner/languages/en'
require 'numbers_and_words/strategies/array_joiner/languages/en_gb'
require 'numbers_and_words/strategies/array_joiner/languages/hu'
require 'numbers_and_words/strategies/array_joiner/languages/ru'
require 'numbers_and_words/strategies/array_joiner/languages/ua'

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        class << self
          def factory strategy
            "#{name}::#{I18n.language_class_name}".constantize.new strategy
          end
        end
      end
    end
  end
end