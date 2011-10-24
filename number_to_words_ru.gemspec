# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{number_to_words_ru}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Kirill Lazarev}]
  s.autorequire = %q{number_to_words_ru}
  s.date = %q{2011-10-24}
  s.description = %q{Simple convert number to russian words using I18N.}
  s.email = %q{k.s.lazarev@gmail.com}
  s.files = [%q{lib/locales}, %q{lib/locales/numbers.en.yml}, %q{lib/locales/numbers.ru.yml}, %q{lib/locales/plurals.rb}, %q{lib/number_to_words_ru}, %q{lib/number_to_words_ru/array_additions}, %q{lib/number_to_words_ru/array_additions/helpers.rb}, %q{lib/number_to_words_ru/array_additions/validations.rb}, %q{lib/number_to_words_ru/array_additions.rb}, %q{lib/number_to_words_ru/core_ext}, %q{lib/number_to_words_ru/core_ext/array.rb}, %q{lib/number_to_words_ru/core_ext/integer.rb}, %q{lib/number_to_words_ru/figures_array.rb}, %q{lib/number_to_words_ru/pluralization.rb}, %q{lib/number_to_words_ru/strategies}, %q{lib/number_to_words_ru/strategies/base.rb}, %q{lib/number_to_words_ru/strategies/en.rb}, %q{lib/number_to_words_ru/strategies/ru.rb}, %q{lib/number_to_words_ru/strategies.rb}, %q{lib/number_to_words_ru/translations_helpers}, %q{lib/number_to_words_ru/translations_helpers/base.rb}, %q{lib/number_to_words_ru/translations_helpers/en.rb}, %q{lib/number_to_words_ru/translations_helpers/ru.rb}, %q{lib/number_to_words_ru/translations_helpers.rb}, %q{lib/number_to_words_ru.rb}, %q{spec/number_to_words_ru}, %q{spec/number_to_words_ru/array}, %q{spec/number_to_words_ru/array/ru_spec.rb}, %q{spec/number_to_words_ru/integer}, %q{spec/number_to_words_ru/integer/ru_spec.rb}, %q{spec/spec_helper.rb}]
  s.homepage = %q{http://github.com/kslazarev/number_to_words_ru}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Simple convert number to russian words using I18N.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
