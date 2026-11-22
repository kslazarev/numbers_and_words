# frozen_string_literal: true

require 'bundler'
require 'open3'
require 'rubygems/package'
require 'tmpdir'

specification = Gem::Specification.load(File.expand_path('../numbers_and_words.gemspec', __dir__))
archive = File.expand_path("../pkg/#{specification.full_name}.gem", __dir__)
packaged = Gem::Package.new(archive).spec
expected_files = Dir.chdir(File.expand_path('..', __dir__)) { Dir['lib/**/*.rb', 'lib/**/*.yml'] }
missing_files = expected_files + ['bin/to_words'] - packaged.files
abort 'Missing packaged executable' unless packaged.executables == ['to_words']
abort "Missing package files: #{missing_files.join(', ')}" unless missing_files.empty?

consumer = <<~'RUBY'
  require 'numbers_and_words'

  expected_version, directory = ARGV
  specification = Gem.loaded_specs.fetch('numbers_and_words')
  abort 'Wrong installed version' unless specification.version.to_s == expected_version
  abort 'Gem loaded outside the isolated consumer' unless File.realpath(specification.full_gem_path).start_with?("#{File.realpath(directory)}/")
  abort 'English conversion failed' unless I18n.with_locale(:en) { 42.to_words } == 'forty-two'
  abort 'Scientific float conversion failed' unless I18n.with_locale(:en) { 1.0e-5.to_words(fraction: true) } == 'zero and one hundred-thousandth'
  abort 'Russian conversion failed' unless I18n.with_locale(:ru) { 2000.to_words } == "\u0434\u0432\u0435 \u0442\u044b\u0441\u044f\u0447\u0438"
  abort 'Italian conversion failed' unless I18n.with_locale(:it) { 17.to_words } == 'diciassette'
  abort 'Dutch pronounced conversion failed' unless I18n.with_locale(:nl) { 1910.to_words(pronounced: true) } == 'negentienhonderd tien'
  abort 'Italian decimal conversion failed' unless I18n.with_locale(:it) { 2.5.to_words(fraction: false) } == 'due virgola cinque'
  abort 'Italian 1.x decimal default failed' unless I18n.with_locale(:it) { 2.5.to_words } == 'due e cinque decimi'
  abort 'Portuguese decimal conversion failed' unless I18n.with_locale(:pt) { 4.5.to_words(fraction: true) } == "quatro inteiros e cinco d\u00e9cimos"
  abort 'Polish cardinal failed' unless I18n.with_locale(:pl) { 21_000.to_words } == 'dwadzieścia jeden tysięcy'
  abort 'Polish decimal failed' unless I18n.with_locale(:pl) { 0.1.to_words(remove_zero: true) } == 'jedna dziesiąta'
  abort 'Polish ordinal failed' unless I18n.with_locale(:pl) { 121.to_words(ordinal: true, gender: :female) } == 'sto dwudziesta pierwsza'
  abort 'Swedish conversion failed' unless I18n.with_locale(:sv) { 1_000_100.to_words } == 'en miljon etthundra'
  abort 'German conversion failed' unless I18n.with_locale(:de) { [21.to_words(ordinal: true), 3.05.to_words] } == ['einundzwanzigste', "drei Komma null f\u00fcnf"]
  I18n.backend.store_translations(:ru, units: { kopeck: { one: "\u043a\u043e\u043f\u0435\u0439\u043a\u0430", few: "\u043a\u043e\u043f\u0435\u0439\u043a\u0438", many: "\u043a\u043e\u043f\u0435\u0435\u043a", gender: :female } })
  abort 'Unit conversion failed' unless I18n.with_locale(:ru) { [21, 22].to_words(unit: :kopeck) } == ["\u0434\u0432\u0430\u0434\u0446\u0430\u0442\u044c \u043e\u0434\u043d\u0430 \u043a\u043e\u043f\u0435\u0439\u043a\u0430", "\u0434\u0432\u0430\u0434\u0446\u0430\u0442\u044c \u0434\u0432\u0435 \u043a\u043e\u043f\u0435\u0439\u043a\u0438"]
  abort 'Unsupported option was not ignored' unless I18n.with_locale(:vi) { 21.to_words(gender: :female) } == 'hai mươi mốt'
  NumbersAndWords.config.strict_options = true
  begin
    I18n.with_locale(:vi) { 21.to_words(gender: :female) }
    abort 'Unsupported option was accepted with strict_options'
  rescue NumbersAndWords::UnsupportedOptionError
    nil
  end
  NumbersAndWords.configure { |config| config.locales = [:en, :ru] }
  abort 'Locale configuration failed' unless I18n.available_locales.sort == [:en, :ru]
  abort 'Configured conversion failed' unless I18n.with_locale(:en) { 42.to_words } == 'forty-two'
  puts "Installed #{specification.full_name}: public APIs passed"
RUBY

Dir.mktmpdir('numbers-and-words-consumer-') do |directory|
  Bundler.with_unbundled_env do
    environment = { 'GEM_HOME' => directory, 'GEM_PATH' => directory }
    system(environment, Gem.ruby, '-S', 'gem', 'install', archive, '--no-document', '--install-dir', directory, exception: true)
    system(environment, Gem.ruby, '-e', consumer, packaged.version.to_s, directory, chdir: directory, exception: true)

    executable = File.join(directory, 'bin', 'to_words')
    output, status = Open3.capture2(environment, Gem.ruby, executable, '--locale', 'ru', '2000', chdir: directory)
    abort "Installed executable failed: #{output.inspect}" unless status.success? && output == "\u0434\u0432\u0435 \u0442\u044b\u0441\u044f\u0447\u0438\n"
    _, errors, status = Open3.capture3(environment, Gem.ruby, executable, 'nope', chdir: directory)
    abort 'Installed executable accepted invalid input' unless status.exitstatus == 1 && errors.include?('Not a number')
    puts 'Installed executable passed'
  end
end
