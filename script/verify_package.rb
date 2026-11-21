# frozen_string_literal: true

require 'bundler'
require 'rubygems/package'
require 'tmpdir'

specification = Gem::Specification.load(File.expand_path('../numbers_and_words.gemspec', __dir__))
archive = File.expand_path("../pkg/#{specification.full_name}.gem", __dir__)
packaged = Gem::Package.new(archive).spec
expected_files = Dir.chdir(File.expand_path('..', __dir__)) { Dir['lib/**/*.rb', 'lib/**/*.yml'] }
missing_files = expected_files - packaged.files
abort "Missing package files: #{missing_files.join(', ')}" unless missing_files.empty?

consumer = <<~'RUBY'
  require 'numbers_and_words'

  expected_version, directory = ARGV
  specification = Gem.loaded_specs.fetch('numbers_and_words')
  abort 'Wrong installed version' unless specification.version.to_s == expected_version
  abort 'Gem loaded outside the isolated consumer' unless File.realpath(specification.full_gem_path).start_with?("#{File.realpath(directory)}/")
  abort 'English conversion failed' unless I18n.with_locale(:en) { 42.to_words } == 'forty-two'
  abort 'Scientific float conversion failed' unless I18n.with_locale(:en) { 1.0e-5.to_words } == 'zero and one hundred-thousandth'
  abort 'Russian conversion failed' unless I18n.with_locale(:ru) { 2000.to_words } == "\u0434\u0432\u0435 \u0442\u044b\u0441\u044f\u0447\u0438"
  abort 'Italian conversion failed' unless I18n.with_locale(:it) { 17.to_words } == 'diciassette'
  abort 'Italian decimal conversion failed' unless I18n.with_locale(:it) { 2.5.to_words } == 'due e cinque decimi'
  abort 'Portuguese decimal conversion failed' unless I18n.with_locale(:pt) { 4.5.to_words } == "quatro inteiros e cinco d\u00e9cimos"
  abort 'Polish cardinal failed' unless I18n.with_locale(:pl) { 21_000.to_words } == 'dwadzieścia jeden tysięcy'
  abort 'Polish decimal failed' unless I18n.with_locale(:pl) { 0.1.to_words(remove_zero: true) } == 'jedna dziesiąta'
  abort 'Polish ordinal failed' unless I18n.with_locale(:pl) { 121.to_words(ordinal: true, gender: :female) } == 'sto dwudziesta pierwsza'
  abort 'Swedish conversion failed' unless I18n.with_locale(:se) { 1_000_100.to_words } == 'en miljon etthundra'
  abort 'German conversion failed' unless I18n.with_locale(:de) { [21.to_words(ordinal: true), 3.05.to_words] } == ['einundzwanzigste', "drei Komma null f\u00fcnf"]
  begin
    I18n.with_locale(:fr) { 21.to_words(ordinal: true) }
    abort 'Unsupported option was accepted'
  rescue NumbersAndWords::UnsupportedOptionError
    nil
  end
  puts "Installed #{specification.full_name}: public APIs passed"
RUBY

Dir.mktmpdir('numbers-and-words-consumer-') do |directory|
  Bundler.with_unbundled_env do
    environment = { 'GEM_HOME' => directory, 'GEM_PATH' => directory }
    system(environment, Gem.ruby, '-S', 'gem', 'install', archive, '--no-document', '--install-dir', directory, exception: true)
    system(environment, Gem.ruby, '-e', consumer, packaged.version.to_s, directory, chdir: directory, exception: true)
  end
end
