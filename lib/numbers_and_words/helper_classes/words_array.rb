require 'numbers_and_words/helper_classes/array_extensions/helpers'
require 'numbers_and_words/helper_classes/array_extensions/validations'

module NumbersAndWords
  class WordsArray < Array

    def join options = {}
      Strategies.array_joiner.new(self.to_a, options).run
    end
  end
end
