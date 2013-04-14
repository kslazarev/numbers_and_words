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
            "#{name}::#{language_class_name}".constantize.new strategy
          end

          def language_class_name
            ::I18n.locale.to_s.titleize.gsub ' ', ''
          end
        end
      end
    end
  end
end