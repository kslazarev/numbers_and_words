# frozen_string_literal: true

require 'numbers_and_words/translations/base'
require 'numbers_and_words/translations/families/base'
require 'numbers_and_words/translations/families/cyrillic'
require 'numbers_and_words/translations/families/latin'
require 'numbers_and_words/translations/extensions/fraction_significance'
require 'numbers_and_words/translations/ru'
require 'numbers_and_words/translations/en'
require 'numbers_and_words/translations/en-GB'
require 'numbers_and_words/translations/ua'
require 'numbers_and_words/translations/tr'
require 'numbers_and_words/translations/fr'
require 'numbers_and_words/translations/nl'
require 'numbers_and_words/translations/it'
require 'numbers_and_words/translations/hu'
require 'numbers_and_words/translations/et'
require 'numbers_and_words/translations/se'
require 'numbers_and_words/translations/es'
require 'numbers_and_words/translations/lv'
require 'numbers_and_words/translations/lt'
require 'numbers_and_words/translations/de'
require 'numbers_and_words/translations/pt'
require 'numbers_and_words/translations/pt-BR'
require 'numbers_and_words/translations/ka'
require 'numbers_and_words/translations/cs'
require 'numbers_and_words/translations/vi'
require 'numbers_and_words/translations/hy'
require 'numbers_and_words/translations/kz'

module NumbersAndWords
  module Translations
    class << self
      def factory
        Object.const_get("#{name}::#{I18n.language_class_name}").new
      end
    end
  end
end
