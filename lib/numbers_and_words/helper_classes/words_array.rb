require 'numbers_and_words/helper_classes/array_extensions/helpers'
require 'numbers_and_words/helper_classes/array_extensions/validations'

module NumbersAndWords
  class WordsArray < Array

    def join options = {}
      local_language { Strategies.array_joiner.new(self.to_a, options).run }
    end

    def local_language
      ::I18n.with_locale(I18n.local_language) { yield }
    end
  end
end
