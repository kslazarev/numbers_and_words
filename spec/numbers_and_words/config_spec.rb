# frozen_string_literal: true

require 'spec_helper'
require 'bundler'
require 'open3'
require 'tempfile'
require 'yaml'

describe NumbersAndWords::Config do
  around do |example|
    backend = I18n.backend
    paths = I18n.load_path.dup
    locales = NumbersAndWords.config.locales
    available = I18n.config.available_locales_initialized? ? I18n.available_locales : nil
    current_locale = I18n.locale
    default_locale = I18n.default_locale
    I18n.backend = I18n::Backend::Simple.new
    I18n.available_locales = nil
    example.run
  ensure
    NumbersAndWords.configure { |config| config.locales = locales }
    I18n.load_path = paths
    I18n.backend = backend
    I18n.available_locales = available
    I18n.default_locale = default_locale
    I18n.locale = current_locale
  end

  it 'loads the locale a configured locale extends, without enabling it' do
    NumbersAndWords.configure { |config| config.locales = [:'en-GB'] }
    expect(I18n.with_locale(:'en-GB') { 1001.to_words(hundreds_with_union: true) }).to eq('one thousand and one')
    expect { I18n.with_locale(:en) { 1.to_words } }.to raise_error(NumbersAndWords::UnsupportedLanguageError)
  end

  it 'merges a locale with the one it extends again after a reload, keeping the keys it drops' do
    I18n.reload!
    expect(I18n.with_locale(:'fr-CH') { [71, 80, 1001].map(&:to_words) }).to eq(%w[septante-et-un huitante mille-un])
    expect(I18n.t('numbers.rules.cardinal', locale: :'fr-CH')).to include(70 => nil).and include(20 => '{tens}[{>and-one}]')
  end

  it 'normalizes aliases and limits translations and pluralization locales after require' do
    I18n.t(:ones, scope: :numbers, locale: :ru)
    NumbersAndWords.configure { |config| config.locales = ['en-US', :ru, :en] }

    expect(I18n.available_locales).to contain_exactly(:en, :ru)
    expect(I18n.with_locale(:en) { 42.to_words }).to eq('forty-two')
    expect(I18n.with_locale(:ru) { 2000.to_words }).to eq('две тысячи')
  end

  it 'preserves application translation files, including unselected languages' do
    Tempfile.create(['application-translations', '.yml']) do |file|
      file.write(YAML.dump('fr' => { 'greeting' => 'bonjour' }))
      file.flush
      I18n.load_path << file.path
      NumbersAndWords.configure { |config| config.locales = [:en] }

      expect(I18n.t(:greeting, locale: :fr)).to eq('bonjour')
      expect(I18n.t(:ones, scope: :numbers, locale: :fr, default: nil)).to be_nil
    end
  end

  it 'rejects conversion in a disabled locale without overriding application available_locales' do
    I18n.available_locales = %i[en ru]
    NumbersAndWords.configure { |config| config.locales = [:en] }

    expect(I18n.available_locales).to eq(%i[en ru])
    expect { I18n.with_locale(:ru) { 1.to_words } }.to raise_error('Language not configured')
  end

  it 'reconfigures loaded translations and restores all languages with nil' do
    NumbersAndWords.configure { |config| config.locales = [:en] }
    I18n.t(:ones, scope: :numbers)
    NumbersAndWords.configure { |config| config.locales = %i[en ru] }
    I18n.default_locale = :ru
    I18n.locale = :ru
    NumbersAndWords.configure { |config| config.locales = [:ru] }
    expect(I18n.with_locale(:ru) { 2.to_words }).to eq('два')

    NumbersAndWords.configure { |config| config.locales = nil }
    expect(I18n.with_locale(:fr) { 2.to_words }).to eq('deux')
  end

  it 'allows an empty selection without silently restoring all bundled translations' do
    NumbersAndWords.configure { |config| config.locales = [] }
    expect(NumbersAndWords::I18n::Pluralization.languages).to be_empty
    expect(I18n.load_path & NumbersAndWords::I18n.locale_files).to be_empty
  end

  [[:unknown], [''], [nil], [123]].each do |selection|
    it "rejects #{selection.inspect} without applying a partial configuration" do
      NumbersAndWords.configure { |config| config.locales = [:en] }
      paths = I18n.load_path.dup

      expect { NumbersAndWords.configure { |config| config.locales = selection } }.to raise_error(ArgumentError, /Unsupported locale/)
      expect(I18n.load_path).to eq(paths)
      expect(I18n.with_locale(:en) { 2.to_words }).to eq('two')
    end
  end

  it 'does not apply a configuration block that raises' do
    NumbersAndWords.configure { |config| config.locales = [:en] }
    expect do
      NumbersAndWords.configure do |config|
        config.locales = [:ru]
        raise 'cancel configuration'
      end
    end.to raise_error('cancel configuration')
    expect(I18n.with_locale(:en) { 2.to_words }).to eq('two')
  end

  it 'applies locales assigned directly on NumbersAndWords.config' do
    NumbersAndWords.config.locales = ['en-US', :ru]

    expect(NumbersAndWords.config.locales).to eq(%i[en ru])
    expect(I18n.available_locales).to contain_exactly(:en, :ru)
    expect(I18n.with_locale(:ru) { 2000.to_words }).to eq('две тысячи')

    NumbersAndWords.config.locales = nil
    expect(I18n.with_locale(:fr) { 2.to_words }).to eq('deux')
  end

  it 'rejects an unsupported locale assigned directly without changing the configuration' do
    NumbersAndWords.config.locales = [:en]
    paths = I18n.load_path.dup

    expect { NumbersAndWords.config.locales = %i[ru unknown] }.to raise_error(ArgumentError, /Unsupported locale/)
    expect(NumbersAndWords.config.locales).to eq([:en])
    expect(I18n.load_path).to eq(paths)
  end

  it 'does not apply settings collected in a configure block until it completes' do
    NumbersAndWords.config.locales = [:en]
    NumbersAndWords.configure do |config|
      config.locales = [:ru]
      expect(NumbersAndWords.config.locales).to eq([:en])
    end
    expect(NumbersAndWords.config.locales).to eq([:ru])
  end

  it 'keeps the configured locales when initialized again' do
    NumbersAndWords.configure { |config| config.locales = %i[en ru] }
    NumbersAndWords::I18n::Initialization.init
    gem_files = I18n.load_path.select { |path| path.start_with?(File.expand_path('../../lib/numbers_and_words/i18n/locales', __dir__)) }
    expect(gem_files.map { |path| NumbersAndWords::I18n.language_of(path) }).to contain_exactly(:en, :ru)
  end

  it 'does not duplicate gem resources on repeated initialization or configuration' do
    2.times { NumbersAndWords::I18n::Initialization.init }
    2.times { NumbersAndWords.configure { |config| config.locales = [:ru] } }
    expect(I18n.load_path).to eq(I18n.load_path.uniq)
  end

  def run_consumer(code, *ruby_options)
    gem_directory = Gem.loaded_specs.fetch('i18n').base_dir
    Bundler.with_unbundled_env do
      Open3.capture3({ 'GEM_HOME' => gem_directory, 'GEM_PATH' => gem_directory }, Gem.ruby, *ruby_options,
                     '-I', File.expand_path('../../lib', __dir__), '-rnumbers_and_words', '-e', code)
    end
  end

  it 'works in a real consumer subprocess with ordinary automatic loading' do
    code = <<~RUBY
      NumbersAndWords.config.locales = [:en, :ru]
      puts I18n.with_locale(:en) { 42.to_words }
      puts I18n.available_locales.sort.join(',')
    RUBY
    output, error, status = run_consumer(code)
    expect(status.success?).to be(true), error
    expect(output).to eq("forty-two\nen,ru\n")
  end

  it 'loads in a real consumer subprocess whose default external encoding is not UTF-8' do
    output, error, status = run_consumer('puts I18n.with_locale(:"fr-CH") { 90.to_words }', '-E', 'US-ASCII')
    expect(status.success?).to be(true), error
    expect(output).to eq("nonante\n")
  end
end
