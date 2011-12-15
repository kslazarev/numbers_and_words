# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "number_to_words_ru"
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kirill Lazarev"]
  s.autorequire = "number_to_words_ru"
  s.date = "2011-12-15"
  s.description = "Simple convert number to russian words using I18N."
  s.email = "k.s.lazarev@gmail.com"
  s.files = ["lib/initializers", "lib/initializers/i18n.rb", "lib/locales", "lib/locales/numbers.en.yml", "lib/locales/numbers.ru.yml", "lib/locales/plurals.rb", "lib/number_to_words_ru", "lib/number_to_words_ru/array_additions", "lib/number_to_words_ru/array_additions/helpers.rb", "lib/number_to_words_ru/array_additions/validations.rb", "lib/number_to_words_ru/array_additions.rb", "lib/number_to_words_ru/core_ext", "lib/number_to_words_ru/core_ext/array.rb", "lib/number_to_words_ru/core_ext/integer.rb", "lib/number_to_words_ru/figures_array.rb", "lib/number_to_words_ru/pluralization.rb", "lib/number_to_words_ru/strategies", "lib/number_to_words_ru/strategies/base.rb", "lib/number_to_words_ru/strategies/en.rb", "lib/number_to_words_ru/strategies/ru.rb", "lib/number_to_words_ru/strategies.rb", "lib/number_to_words_ru/translations_helpers", "lib/number_to_words_ru/translations_helpers/base.rb", "lib/number_to_words_ru/translations_helpers/en.rb", "lib/number_to_words_ru/translations_helpers/ru.rb", "lib/number_to_words_ru/translations_helpers.rb", "lib/number_to_words_ru.rb", "spec/number_to_words_ru", "spec/number_to_words_ru/array", "spec/number_to_words_ru/array/ru_spec.rb", "spec/number_to_words_ru/integer", "spec/number_to_words_ru/integer/ru_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/kslazarev/number_to_words_ru"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Simple convert number to russian words using I18N."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
