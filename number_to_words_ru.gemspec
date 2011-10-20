# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{number_to_words_ru}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Kirill Lazarev}]
  s.autorequire = %q{number_to_words_ru}
  s.date = %q{2011-08-19}
  s.description = %q{Simple convert number to russian words using I18N.}
  s.email = %q{k.s.lazarev@gmail.com}
  s.files = [%q{lib/locales}, %q{lib/locales/integer.ru.yml}, %q{lib/locales/plurals.rb}, %q{lib/number_to_words_ru}, %q{lib/number_to_words_ru/array_additions.rb}, %q{lib/number_to_words_ru/integer.rb}, %q{lib/number_to_words_ru.rb}, %q{spec/number_to_words_ru}, %q{spec/number_to_words_ru/integer_spec.rb}, %q{spec/spec_helper.rb}]
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
