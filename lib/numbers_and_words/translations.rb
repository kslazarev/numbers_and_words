# frozen_string_literal: true

require 'numbers_and_words/i18n'
require 'numbers_and_words/translations/base'
require 'numbers_and_words/translations/extensions/portuguese_fractions'
require 'numbers_and_words/translations/de'
require 'numbers_and_words/translations/pt'
require 'numbers_and_words/translations/pt-BR'
require 'numbers_and_words/translations/cs'
require 'numbers_and_words/translations/ja'
require 'numbers_and_words/translations/he'
require 'numbers_and_words/translations/bg'
require 'numbers_and_words/translations/sk'
require 'numbers_and_words/translations/pl'
require 'numbers_and_words/translations/ro'
require 'numbers_and_words/translations/el'

module NumbersAndWords
  module Translations
    I18n.define_classes(self) { Class.new(Base) }

    class << self
      def factory
        Object.const_get("#{name}::#{I18n.language_class_name}").new
      end
    end
  end
end
