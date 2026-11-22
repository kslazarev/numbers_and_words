# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Compatibility, :compatibility do
  def words(locale, number, options = {})
    I18n.with_locale(locale) { number.to_words(options) }
  end

  # Every fixture without the option reads as 1.x did: the same as passing the 1.x default explicitly.
  NumbersAndWords::I18n.languages.to_h { |locale| [locale, described_class.legacy_defaults(locale)] }.reject { |_, defaults| defaults.empty? }.each do |locale, defaults|
    [Integer, Float].each do |type|
      next if type == Float && !decimal_languages.include?(locale)

      it "keeps the 1.x defaults #{defaults.transform_values(&:first)} of every #{type} fixture in #{locale}" do
        examples = fixture_examples(type, locale)['to_words'].values.flat_map do |tests|
          options = tests['options'] || {}
          tests.except('options').keys.map { |number| [number, options] }
        end
        examples.reject! { |_number, options| defaults.keys.any? { |name| options.key?(name) } }
        allow(Kernel).to receive(:warn)

        expected = examples.map { |number, options| words(locale, number, options.merge(defaults.transform_values(&:first))) }

        expect(examples).not_to be_empty
        expect(examples.map { |number, options| words(locale, number, options) }).to eq(expected)
      end
    end
  end

  describe 'defaults that change in 2.0' do
    {
      [:en, 21.77, { fraction: false }] => ['twenty-one and seventy-seven hundredths', 'twenty-one point seven seven'],
      [:'en-GB', 101, { hundreds_with_union: true }] => ['one hundred one', 'one hundred and one'],
      [:'en-GB', 1001, { hundreds_with_union: true }] => ['one thousand one', 'one thousand and one'],
      [:fr, 321, { spelling: :reformed }] => ['trois cent vingt et un', 'trois-cent-vingt-et-un'],
      [:fr, 3.05, { fraction: false }] => ['trois et cinq centièmes', 'trois virgule zéro cinq'],
      [:'fr-CH', 81, { spelling: :reformed }] => ['huitante et un', 'huitante-et-un'],
      [:it, 21.77, { fraction: false }] => ['ventuno e settantasette centesimi', 'ventuno virgola settantasette'],
      [:pt, 21.77, { fraction: false }] => ['vinte e um inteiros e setenta e sete centésimos', 'vinte e um vírgula setenta e sete'],
      [:'pt-BR', 21.77, { fraction: false }] => ['vinte e um inteiros e setenta e sete centésimos', 'vinte e um vírgula setenta e sete']
    }.each do |(locale, number, upcoming_options), (current, upcoming)|
      it "reads #{number} in #{locale} as 1.x did by default, and as 2.0 will with #{upcoming_options}" do
        allow(Kernel).to receive(:warn)
        expect([words(locale, number), words(locale, number, upcoming_options)]).to eq([current, upcoming])
      end
    end

    it 'warns once about each default it applies, as a deprecation' do
      allow(Kernel).to receive(:warn)
      2.times { words(:fr, 321) }
      expect(Kernel).to have_received(:warn).once.with(
        'numbers_and_words: The default spelling: :traditional for :fr changes to spelling: :reformed in 2.0; pass spelling: to choose.',
        category: :deprecated
      )
    end

    it 'does not warn when the option is passed' do
      allow(Kernel).to receive(:warn)
      expect([words(:fr, 321, spelling: :reformed), words(:en, 1.5, fraction: false)]).to eq(['trois-cent-vingt-et-un', 'one point five'])
      expect(Kernel).not_to have_received(:warn)
    end

    it 'does not warn about decimal readings for integers' do
      allow(Kernel).to receive(:warn)
      expect(words(:en, 21)).to eq('twenty-one')
      expect(Kernel).not_to have_received(:warn)
    end

    it 'applies decimal defaults to arrays with a decimal' do
      allow(Kernel).to receive(:warn)
      expect(words(:en, [1, 1.5])).to eq(['one', 'one and five tenths'])
    end

    it 'keeps the decimal point reading of amounts with a unit' do
      backend = I18n.backend
      I18n.backend = I18n::Backend::Simple.new
      I18n.backend.store_translations(:en, units: { dollar: { one: 'dollar', other: 'dollars' } })
      allow(Kernel).to receive(:warn)
      expect(words(:en, 1.5, unit: :dollar)).to eq('one point five dollars')
      expect(Kernel).not_to have_received(:warn)
    ensure
      I18n.backend = backend
    end
  end

  describe 'unsupported options' do
    it 'ignores an unsupported option with a warning' do
      allow(Kernel).to receive(:warn)
      expect(words(:vi, 21, gender: :female)).to eq('hai mươi mốt')
      expect(Kernel).to have_received(:warn).with(
        'numbers_and_words: The option :gender is not supported in :vi; supported: :micro_separator, :ordinal, :precision, :remove_zero, ' \
        ':subunit, :unit, :zero_subunit. It is ignored; set NumbersAndWords.config.strict_options = true to raise, the default in 2.0.',
        category: nil
      )
    end

    it 'ignores an unsupported value with a warning' do
      allow(Kernel).to receive(:warn)
      expect(words(:es, 1, gender: :neuter)).to eq('uno')
      expect(Kernel).to have_received(:warn).with(/The value :neuter of option :gender is not supported in :es/, category: nil)
    end

    it 'keeps the supported options' do
      allow(Kernel).to receive(:warn)
      expect(words(:es, 1, gender: :female, foo: true)).to eq('una')
    end

    it 'raises with strict_options = true' do
      NumbersAndWords.config.strict_options = true
      expect { words(:vi, 21, gender: :female) }.to raise_error(NumbersAndWords::UnsupportedOptionError)
    end
  end

  describe 'locale codes used before 1.1.0' do
    { se: 'tjugoett', ua: 'двадцять один', kz: 'жиырма бір' }.each do |code, expected|
      it "converts in #{code} with a warning" do
        allow(Kernel).to receive(:warn)
        expect(words(code, 21)).to eq(expected)
        expect(Kernel).to have_received(:warn).with(/locale #{code.inspect} is deprecated/, category: nil)
      end
    end

    it 'registers a code only while its language is loaded' do
      backend = I18n.backend
      paths = I18n.load_path.dup
      available = I18n.config.available_locales_initialized? ? I18n.available_locales : nil
      I18n.backend = I18n::Backend::Simple.new
      I18n.available_locales = nil
      NumbersAndWords.configure { |config| config.locales = %i[en ru] }
      expect(I18n.available_locales).not_to include(:se, :ua, :kz)
      NumbersAndWords.configure { |config| config.locales = %i[en sv] }
      expect(I18n.available_locales).to include(:se)
    ensure
      NumbersAndWords.configure { |config| config.locales = nil }
      I18n.load_path = paths
      I18n.backend = backend
      I18n.available_locales = available
    end
  end

  describe NumbersAndWords::Config do
    it 'defaults strict_options to false' do
      expect(described_class.new.strict_options).to be(false)
    end

    it 'rejects a strict_options value other than true or false' do
      expect { NumbersAndWords.config.strict_options = nil }.to raise_error(ArgumentError, 'The strict_options setting must be true or false, not nil.')
    end

    it 'keeps strict_options when configured' do
      NumbersAndWords.configure { |config| config.strict_options = true }
      expect(NumbersAndWords.config.strict_options).to be(true)
    end
  end
end
