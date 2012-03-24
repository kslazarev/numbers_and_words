# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "numbers_and_words"
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kirill Lazarev"]
  s.autorequire = "numbers_and_words"
  s.date = "2011-12-15"
  s.description = "Simple convert number to russian words using I18N."
  s.email = "k.s.lazarev@gmail.com"
  s.files = ["lib/initializers", "lib/initializers/i18n.rb", "lib/locales", "lib/locales/numbers.en.yml", "lib/locales/numbers.ru.yml", "lib/locales/plurals.rb", "lib/numbers_and_words", "lib/numbers_and_words/array_additions", "lib/numbers_and_words/array_additions/helpers.rb", "lib/numbers_and_words/array_additions/validations.rb", "lib/numbers_and_words/array_additions.rb", "lib/numbers_and_words/core_ext", "lib/numbers_and_words/core_ext/array.rb", "lib/numbers_and_words/core_ext/integer.rb", "lib/numbers_and_words/figures_array.rb", "lib/numbers_and_words/pluralization.rb", "lib/numbers_and_words/strategies", "lib/numbers_and_words/strategies/base.rb", "lib/numbers_and_words/strategies/en.rb", "lib/numbers_and_words/strategies/ru.rb", "lib/numbers_and_words/strategies.rb", "lib/numbers_and_words/translations_helpers", "lib/numbers_and_words/translations_helpers/base.rb", "lib/numbers_and_words/translations_helpers/en.rb", "lib/numbers_and_words/translations_helpers/ru.rb", "lib/numbers_and_words/translations_helpers.rb", "lib/numbers_and_words.rb", "spec/numbers_and_words", "spec/numbers_and_words/array", "spec/numbers_and_words/array/ru_spec.rb", "spec/numbers_and_words/integer", "spec/numbers_and_words/integer/ru_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/kslazarev/numbers_and_words"
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
