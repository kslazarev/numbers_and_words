Gem::Specification.new do |s|
  s.name        = 'number_to_words_ru'
  s.version     = '0.0.1'
  s.date        = '2011-07-27'
  s.summary     = "Number to russian words"
  s.description = "Simple translate from number to words using I18N. (Russian Only)"
  s.authors     = ["Kirill Lazarev"]
  s.email       = 'k.s.lazarev@gmail.com'
  s.files       = [
    'lib/number_to_words_ru.rb',
    'lib/number_to_words_ru/integer.rb',
    'lib/pluralization.rb',
    'lib/locales/integer.ru.yml',
    'lib/locales/plurals.rb'
  ]
end