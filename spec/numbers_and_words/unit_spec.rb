# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Unit do
  # Units are application translations: each example stores its own in a fresh backend.
  around do |example|
    backend = I18n.backend
    I18n.backend = I18n::Backend::Simple.new
    I18n.backend.store_translations(:en, units: { dollar: { one: 'dollar', other: 'dollars' }, metre: 'm' })
    I18n.backend.store_translations(:ru, units: {
                                      ruble: { one: 'рубль', few: 'рубля', many: 'рублей', other: 'рубля', gender: 'male' },
                                      kopeck: { one: 'копейка', few: 'копейки', many: 'копеек', other: 'копейки', gender: :female },
                                      apple: { one: 'яблоко', few: 'яблока', many: 'яблок', other: 'яблока', gender: :neuter },
                                      piece: { one: 'штука', few: 'штуки', many: 'штук', other: 'штуки' },
                                      currency: { ruble: { one: 'рубль', few: 'рубля', many: 'рублей', other: 'рубля' } },
                                      broken: { one: 'один', few: 'несколько' },
                                      odd: { one: 'x', other: 'y', gender: :common }
                                    })
    example.run
  ensure
    I18n.backend = backend
  end

  def words(locale, number, **options)
    I18n.with_locale(locale) { number.to_words(**options) }
  end

  describe 'English' do
    it 'chooses one or other' do
      expect([0, 1, 2, 21, 100].map { |number| words(:en, number, unit: :dollar) })
        .to eq(['zero dollars', 'one dollar', 'two dollars', 'twenty-one dollars', 'one hundred dollars'])
    end

    it 'accepts a string key and a unit without plural forms' do
      expect([words(:en, 2, unit: 'dollar'), words(:en, 5, unit: :metre)]).to eq(['two dollars', 'five m'])
    end

    it 'chooses the form of a negative number by its absolute value, as the number is spelled' do
      expect([words(:en, -1, unit: :dollar), words(:en, -2, unit: :dollar)]).to eq(['one dollar', 'two dollars'])
    end

    it 'uses the singular form for ordinals' do
      expect([words(:en, 1, unit: :dollar, ordinal: true), words(:en, 21, unit: :dollar, ordinal: true)]).to eq(['first dollar', 'twenty-first dollar'])
    end

    it 'converts every element of an array' do
      expect(words(:en, [1, 2], unit: :dollar)).to eq(['one dollar', 'two dollars'])
    end

    it 'ignores a gender in a language without genders' do
      I18n.backend.store_translations(:en, units: { coin: { one: 'coin', other: 'coins', gender: :female } })
      expect(words(:en, 1, unit: :coin)).to eq('one coin')
    end
  end

  describe 'Russian' do
    {
      1 => 'один рубль', 2 => 'два рубля', 4 => 'четыре рубля', 5 => 'пять рублей', 11 => 'одиннадцать рублей',
      12 => 'двенадцать рублей', 14 => 'четырнадцать рублей', 21 => 'двадцать один рубль', 22 => 'двадцать два рубля',
      25 => 'двадцать пять рублей', 111 => 'сто одиннадцать рублей', 1000 => 'одна тысяча рублей', 0 => 'ноль рублей'
    }.each do |number, expected|
      it "spells #{number}" do
        expect(words(:ru, number, unit: :ruble)).to eq(expected)
      end
    end

    it 'takes the gender from the unit' do
      expect([1, 2, 21, 22, 25].map { |number| words(:ru, number, unit: :kopeck) })
        .to eq(['одна копейка', 'две копейки', 'двадцать одна копейка', 'двадцать две копейки', 'двадцать пять копеек'])
      expect(words(:ru, 1, unit: :apple)).to eq('одно яблоко')
    end

    it 'lets an explicit gender override the unit' do
      expect([words(:ru, 2, unit: :piece), words(:ru, 2, unit: :piece, gender: :female), words(:ru, 1, unit: :kopeck, gender: :male)])
        .to eq(['два штуки', 'две штуки', 'один копейка'])
    end

    it 'combines with ordinals in the singular and the gender of the unit' do
      expect([words(:ru, 21, unit: :ruble, ordinal: true), words(:ru, 22, unit: :kopeck, ordinal: true)])
        .to eq(['двадцать первый рубль', 'двадцать вторая копейка'])
    end

    it 'accepts only the nominative case, the case of unit forms' do
      expect(words(:ru, 21, unit: :ruble, ordinal: true, case: :nominative)).to eq('двадцать первый рубль')
      expect { words(:ru, 21, unit: :ruble, ordinal: true, case: :genitive) }
        .to raise_error(NumbersAndWords::UnsupportedOptionError, 'unit :ruble cannot be used with case: :genitive yet; unit forms are nominative')
    end

    it 'looks up a dotted key under units' do
      expect(words(:ru, 5, unit: 'currency.ruble')).to eq('пять рублей')
    end

    it 'validates the gender of the unit for the language' do
      expect { words(:ru, 1, unit: :odd) }.to raise_error(NumbersAndWords::UnsupportedOptionError, /unsupported value :common for option :gender in locale :ru/)
    end
  end

  describe 'other languages' do
    before do
      I18n.backend.store_translations(:ua, units: { hryvnia: { one: 'гривня', few: 'гривні', many: 'гривень', other: 'гривні', gender: :female } })
      I18n.backend.store_translations(:pl, units: { zloty: { one: 'złoty', few: 'złote', many: 'złotych', other: 'złotego' },
                                                    koruna: { one: 'korona', few: 'korony', many: 'koron', other: 'korony', gender: :female } })
      I18n.backend.store_translations(:cs, units: { koruna: { one: 'koruna', few: 'koruny', many: 'korun', other: 'koruny', gender: :female } })
      I18n.backend.store_translations(:zh, units: { yuan: '元' })
      I18n.backend.store_translations(:th, units: { baht: 'บาท' })
    end

    it 'spells Ukrainian' do
      expect([1, 2, 5, 11, 21, 22, 25].map { |number| words(:ua, number, unit: :hryvnia) })
        .to eq(['одна гривня', 'дві гривні', 'п’ять гривень', 'одинадцять гривень', 'двадцять одна гривня', 'двадцять дві гривні', 'двадцять п’ять гривень'])
    end

    it 'spells Polish' do
      expect([1, 2, 5, 12, 21, 22, 25].map { |number| words(:pl, number, unit: :zloty) })
        .to eq(['jeden złoty', 'dwa złote', 'pięć złotych', 'dwanaście złotych', 'dwadzieścia jeden złotych', 'dwadzieścia dwa złote', 'dwadzieścia pięć złotych'])
      expect(words(:pl, 2, unit: :koruna)).to eq('dwie korony')
    end

    it 'spells Czech' do
      expect([1, 2, 5].map { |number| words(:cs, number, unit: :koruna) }).to eq(['jedna koruna', 'dvě koruny', 'pět korun'])
    end

    it 'writes the unit without a space in languages written without spaces' do
      expect([words(:zh, 21, unit: :yuan), words(:th, 21, unit: :baht)]).to eq(%w[二十一元 ยี่สิบเอ็ดบาท])
    end

    it 'looks the unit up in the fallback locale' do
      available_locales = I18n.available_locales
      I18n.available_locales = available_locales | [:ko]
      expect(words(:ko, 3, unit: :dollar, fallback: :en)).to eq('three dollars')
    ensure
      I18n.available_locales = available_locales
    end
  end

  describe 'errors' do
    it 'raises for a unit without a translation' do
      expect { words(:ru, 1, unit: :dollar) }
        .to raise_error(NumbersAndWords::UnsupportedOptionError, 'unit :dollar has no translation for locale :ru (expected units.dollar)')
    end

    it 'raises for a unit without the form a number needs' do
      expect(words(:ru, 1, unit: :broken)).to eq('один один')
      expect { words(:ru, 5, unit: :broken) }
        .to raise_error(NumbersAndWords::UnsupportedOptionError, 'unit :broken has no form for count 5 or :other in locale :ru (units.broken)')
    end

    it 'raises for decimals' do
      message = 'unit :ruble cannot be used with decimals such as 1.5 yet, see https://github.com/kslazarev/numbers_and_words/issues/295'
      expect { words(:ru, 1.5, unit: :ruble) }.to raise_error(NumbersAndWords::UnsupportedOptionError, message)
      expect { words(:ru, [1, 1.5], unit: :ruble) }.to raise_error(NumbersAndWords::UnsupportedOptionError, message)
    end

    [nil, '', 1, true].each do |value|
      it "rejects unit: #{value.inspect}" do
        expect { words(:en, 1, unit: value) }
          .to raise_error(NumbersAndWords::UnsupportedOptionError, /for option :unit in locale :en; supported: a unit translation key/)
      end
    end
  end

  it 'leaves numbers without a unit unchanged' do
    expect([words(:en, 21), words(:en, 1.5), words(:en, [1, 2])]).to eq(['twenty-one', 'one point five', %w[one two]])
  end
end
