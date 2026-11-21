# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::OptionsValidation do
  def words(locale, number, options)
    I18n.with_locale(locale) { number.to_words(options) }
  end

  it 'raises an ArgumentError subclass' do
    expect(NumbersAndWords::UnsupportedOptionError.ancestors).to include(ArgumentError)
  end

  context 'with an option the language does not define' do
    it 'raises and lists the supported options' do
      expect { words(:vi, 21, gender: :female) }
        .to raise_error(NumbersAndWords::UnsupportedOptionError, 'unsupported option :gender for locale :vi; supported: :micro_separator, :ordinal, :precision, :remove_zero, :unit')
    end

    it 'rejects misspelled options' do
      expect { words(:en, 21, ordnal: true) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /unsupported option :ordnal for locale :en/)
    end

    it 'rejects options of another language' do
      expect { words(:ru, 1, apocopated: true) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /:apocopated for locale :ru/)
    end

    it 'rejects internal options' do
      expect { words(:en, 1, integral: {}) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /:integral/)
    end
  end

  context 'with an unsupported value' do
    it 'rejects a gender the language does not have' do
      expect { words(:es, 1, gender: :neuter) }
        .to raise_error(NumbersAndWords::UnsupportedOptionError, 'unsupported value :neuter for option :gender in locale :es; supported: :male, :female')
    end

    it 'rejects a gender from another language' do
      expect { words(:da, 1, gender: :male) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /supported: :common, :neuter/)
    end

    it 'rejects non-boolean flags' do
      expect { words(:en, 21, ordinal: 'yes') }.to raise_error(NumbersAndWords::UnsupportedOptionError, /supported: true, false/)
    end

    it 'rejects a negative or non-integer precision' do
      expect { words(:en, 0.1, precision: -1) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /a non-negative integer/)
      expect { words(:en, 0.1, precision: 1.5) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /a non-negative integer/)
    end

    it 'rejects a non-string micro separator' do
      expect { words(:en, 0.1, micro_separator: 1) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /a string/)
    end
  end

  context 'with supported options' do
    it 'accepts language options, false flags and string genders' do
      expect([words(:en, 21, ordinal: true), words(:en, 21, ordinal: false), words(:ru, 1, gender: 'female')]).to eq(%w[twenty-first twenty-one одна])
    end

    it 'accepts global options in every language' do
      NumbersAndWords::I18n.languages.each do |locale|
        expect { words(locale, 1, precision: 2, micro_separator: ' ') }.not_to raise_error
      end
    end

    it 'accepts no options' do
      expect([words(:fr, 1, {}), I18n.with_locale(:fr) { 1.to_words }]).to eq(%w[un un])
    end
  end

  it 'validates floats and arrays' do
    expect { words(:vi, 0.5, gender: :female) }.to raise_error(NumbersAndWords::UnsupportedOptionError)
    expect { words(:vi, [1, 2], gender: :female) }.to raise_error(NumbersAndWords::UnsupportedOptionError)
  end

  it 'resolves regional aliases to their language' do
    available = I18n.available_locales
    I18n.available_locales = available + [:'en-US']
    expect(words(:'en-US', 21, ordinal: true)).to eq('twenty-first')
    expect { words(:'en-US', 1, gender: :female) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /locale :en;/)
  ensure
    I18n.available_locales = available
  end

  it 'builds each language table once' do
    expect(described_class.supported_options(:en)).to be_frozen.and equal(described_class.supported_options(:en))
  end

  it 'validates an array once, not again for every element' do
    allow(described_class).to receive(:validate!).and_call_original
    I18n.with_locale(:en) { [1, 2.5, 3].to_words(ordinal: true) }
    expect(described_class).to have_received(:validate!).once
  end

  it 'lists the options of each language' do
    expect(described_class.supported_options(:fr).keys).to contain_exactly(:fraction, :ordinal, :remove_zero, :spelling, :precision, :micro_separator, :unit)
    expect(described_class.supported_options(:es).keys).to contain_exactly(:apocopated, :gender, :ordinal, :remove_zero, :precision, :micro_separator, :unit)
  end
end
