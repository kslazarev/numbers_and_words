require 'numbers_and_words/translations/base'
require 'numbers_and_words/translations/families/base'
require 'numbers_and_words/translations/families/cyrillic'
require 'numbers_and_words/translations/families/latin'
require 'numbers_and_words/translations/extensions/fraction_significance'
require 'numbers_and_words/translations/ru'
require 'numbers_and_words/translations/en'
require 'numbers_and_words/translations/en_gb'
require 'numbers_and_words/translations/ua'
require 'numbers_and_words/translations/tr'
require 'numbers_and_words/translations/fr'
require 'numbers_and_words/translations/nl'
require 'numbers_and_words/translations/it'
require 'numbers_and_words/translations/hu'
require 'numbers_and_words/translations/se'
require 'numbers_and_words/translations/es'
require 'numbers_and_words/translations/lv'

module NumbersAndWords
  module Translations
    class << self
      def factory
        "#{name}::#{I18n.language_class_name}".constantize.new
      end
    end
  end
end