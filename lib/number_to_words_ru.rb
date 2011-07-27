require 'rubygems'

require 'i18n'
require 'pluralization'

I18n.load_path = [
  Dir.pwd + '/lib/locales/integer.ru.yml',
  Dir.pwd + '/lib/locales/plurals.rb'
]
I18n.locale = :ru

require 'number_to_words_ru/integer'


