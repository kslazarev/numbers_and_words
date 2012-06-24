require 'numbers_and_words/i18n/pluralization'
require 'numbers_and_words/i18n/initialization'

module NumbersAndWords
  module I18n
    extend self

    def files directory, ext
      Dir[File.join(File.dirname(__FILE__), "i18n/#{directory}", "**/#{ext}")]
    end
  end
end