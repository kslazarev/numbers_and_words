require 'rubygems'

require 'i18n'
require 'pluralization'
I18n.load_path = ['locales/integer.ru.yml', 'locales/plurals.rb']
I18n.locale = :ru

require 'number_to_words_ru/integer'


