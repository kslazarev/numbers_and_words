# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Unit do
  # Units are application translations: each example stores its own in a fresh backend.
  around do |example|
    backend = I18n.backend
    I18n.backend = I18n::Backend::Simple.new
    I18n.backend.store_translations(:en, units: { dollar: { one: 'dollar', other: 'dollars' }, cent: { one: 'cent', other: 'cents' }, metre: 'm' })
    I18n.backend.store_translations(:fr, units: { euro: { one: 'euro', other: 'euros' }, centime: { one: 'centime', other: 'centimes' } })
    I18n.backend.store_translations(:pt, units: { euro: { one: 'euro', other: 'euros' } })
    I18n.backend.store_translations(:cs, units: { koruna: { one: 'koruna', few: 'koruny', many: 'korun', other: 'koruny', gender: :female } })
    I18n.backend.store_translations(:th, units: { baht: 'บาท', satang: 'สตางค์' })
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
      I18n.backend.store_translations(:uk, units: { hryvnia: { one: 'гривня', few: 'гривні', many: 'гривень', other: 'гривні', gender: :female } })
      I18n.backend.store_translations(:pl, units: { zloty: { one: 'złoty', few: 'złote', many: 'złotych', other: 'złotego' },
                                                    koruna: { one: 'korona', few: 'korony', many: 'koron', other: 'korony', gender: :female } })
      I18n.backend.store_translations(:cs, units: { koruna: { one: 'koruna', few: 'koruny', many: 'korun', other: 'koruny', gender: :female } })
      I18n.backend.store_translations(:zh, units: { yuan: '元' })
      I18n.backend.store_translations(:th, units: { baht: 'บาท' })
    end

    it 'spells Ukrainian' do
      expect([1, 2, 5, 11, 21, 22, 25].map { |number| words(:uk, number, unit: :hryvnia) })
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

    it 'raises for a subunit without a unit, and zero_subunit without a subunit' do
      expect { words(:en, 1, subunit: :cent) }.to raise_error(NumbersAndWords::UnsupportedOptionError, 'subunit needs a unit')
      expect { words(:en, 1, unit: :dollar, zero_subunit: true) }.to raise_error(NumbersAndWords::UnsupportedOptionError, 'zero_subunit needs a subunit')
    end

    it 'raises for a subunit with ordinal: true or precision: 0' do
      expect { words(:en, 1.5, unit: :dollar, subunit: :cent, ordinal: true) }
        .to raise_error(NumbersAndWords::UnsupportedOptionError, 'subunit cannot be used with ordinal: true')
      expect { words(:en, 1.5, unit: :dollar, subunit: :cent, precision: 0) }
        .to raise_error(NumbersAndWords::UnsupportedOptionError, 'subunit needs precision: of at least 1')
    end

    it 'raises for a decimal when the unit has no form for it' do
      expect { words(:ru, 1.5, unit: :broken) }
        .to raise_error(NumbersAndWords::UnsupportedOptionError, 'unit :broken has no form for 1.5 or :other in locale :ru (units.broken)')
    end

    [nil, '', 1, true].each do |value|
      it "rejects unit: #{value.inspect}" do
        expect { words(:en, 1, unit: value) }
          .to raise_error(NumbersAndWords::UnsupportedOptionError, /for option :unit in locale :en; supported: a unit translation key/)
      end
    end
  end

  describe 'decimals' do
    it 'takes the other form after a decimal, the genitive singular in Russian and Czech' do
      expect([words(:en, 1.5, unit: :dollar), words(:ru, 1.5, unit: :ruble), words(:ru, 21.5, unit: :kopeck), words(:cs, 1.5, unit: :koruna)])
        .to eq(['one point five dollars', 'одна целая и пять десятых рубля', 'двадцать одна целая и пять десятых копейки', 'jedna celá pět desetin koruny'])
    end

    it 'takes the singular below two in French and Portuguese' do
      expect([words(:fr, 1.5, unit: :euro), words(:fr, 2.5, unit: :euro), words(:pt, 0.5, unit: :euro), words(:pt, 3.5, unit: :euro)])
        .to eq(['un virgule cinq euro', 'deux virgule cinq euros', 'zero vírgula cinco euro', 'três vírgula cinco euros'])
    end

    it 'reads a whole float as a whole number, and decimals in arrays' do
      expect([words(:en, 2.0, unit: :dollar), words(:ru, 21.0, unit: :kopeck), words(:en, [1, 1.5], unit: :dollar)])
        .to eq(['two dollars', 'двадцать одна копейка', ['one dollar', 'one point five dollars']])
    end

    it 'keeps the fraction reading with fraction: true' do
      expect(words(:en, 1.5, unit: :dollar, fraction: true)).to eq('one and five tenths dollars')
    end
  end

  describe 'subunits' do
    it 'spells the decimal places as a second unit, joined as the language joins them' do
      expect([words(:en, 21.5, unit: :dollar, subunit: :cent), words(:ru, 21.5, unit: :ruble, subunit: :kopeck),
              words(:ru, 22.22, unit: :ruble, subunit: :kopeck), words(:fr, 21.01, unit: :euro, subunit: :centime),
              words(:th, 21.5, unit: :baht, subunit: :satang)])
        .to eq(['twenty-one dollars and fifty cents', 'двадцать один рубль пятьдесят копеек', 'двадцать два рубля двадцать две копейки',
                'vingt-et-un euros et un centime', 'ยี่สิบเอ็ดบาทห้าสิบสตางค์'])
    end

    it 'rounds to the subunit half to even, exactly' do
      expect([0.125, 0.135, 2.675, 1.0e-05].map { |number| words(:en, number, unit: :dollar, subunit: :cent) })
        .to eq(['zero dollars and twelve cents', 'zero dollars and fourteen cents', 'two dollars and sixty-eight cents', 'zero dollars'])
    end

    it 'uses precision: as the number of decimal places in a subunit' do
      expect(words(:en, 1.005, unit: :dollar, subunit: :cent, precision: 3)).to eq('one dollar and five cents')
    end

    it 'leaves out a zero subunit unless zero_subunit: true, and a zero unit with remove_zero: true' do
      expect([words(:en, 21, unit: :dollar, subunit: :cent), words(:en, 21, unit: :dollar, subunit: :cent, zero_subunit: true),
              words(:en, 0.5, unit: :dollar, subunit: :cent, remove_zero: true), words(:ru, 0.01, unit: :ruble, subunit: :kopeck, remove_zero: true),
              words(:en, 0, unit: :dollar, subunit: :cent, remove_zero: true)])
        .to eq(['twenty-one dollars', 'twenty-one dollars and zero cents', 'fifty cents', 'одна копейка', 'zero dollars'])
    end

    it 'spells negative amounts by their absolute value, as numbers are spelled' do
      expect(words(:en, -3.5, unit: :dollar, subunit: :cent)).to eq('three dollars and fifty cents')
    end
  end

  it 'leaves numbers without a unit unchanged' do
    expect([words(:en, 21), words(:en, 1.5), words(:en, [1, 2])]).to eq(['twenty-one', 'one point five', %w[one two]])
  end
end
