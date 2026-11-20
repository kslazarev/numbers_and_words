# frozen_string_literal: true

require_relative 'lib/numbers_and_words/version'

Gem::Specification.new do |s|
  s.name = 'numbers_and_words'
  s.version = NumbersAndWords::VERSION
  s.authors = ['Kirill Lazarev']
  s.email = 'k.s.lazarev@gmail.com'
  s.homepage = 'https://github.com/kslazarev/numbers_and_words'
  s.license = 'MIT'
  s.summary = 'Spell out numbers in several languages'
  s.description = 'This gem spells out numbers in several languages using the I18n gem.'
  s.required_ruby_version = '>= 3.2.0'
  s.files = Dir['lib/**/*'] + ['bin/to_words']
  s.bindir = 'bin'
  s.executables = ['to_words']
  s.extra_rdoc_files = %w[CHANGELOG.md LICENSE.txt README.md]
  s.require_paths = ['lib']
  s.metadata = {
    'changelog_uri' => 'https://github.com/kslazarev/numbers_and_words/blob/master/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/kslazarev/numbers_and_words'
  }
  s.add_dependency 'i18n'
end
