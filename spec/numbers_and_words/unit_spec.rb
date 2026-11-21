# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Unit do
  # Units are application translations: each example stores its own in a fresh backend.
  around do |example|
    backend = I18n.backend
    I18n.backend = I18n::Backend::Simple.new
    I18n.backend.store_translations(:en, units: { dollar: { one: 'dollar', other: 'dollars' }, cent: { one: 'cent', other: 'cents' }, metre: 'm' })
    I18n.backend.store_translations(:fr, units: { euro: { one: 'euro', other: 'euros' }, centime: { one: 'centime', other: 'centimes' } })
    I18n.backend.store_translations(:pt, units: { euro: { one: 'euro', other: 'euros' }, centimo: { one: 'cêntimo', other: 'cêntimos' } })
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

    it 'chooses the form of a negative number by its absolute value, after the minus word' do
      expect([words(:en, -1, unit: :dollar), words(:en, -2, unit: :dollar)]).to eq(['minus one dollar', 'minus two dollars'])
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
      I18n.backend.store_translations(:ja, units: { yen: '円' })
      I18n.backend.store_translations(:ko, units: { won: '원' })
      I18n.backend.store_translations(:ro, units: { leu: { one: 'leu', few: 'lei', other: 'de lei' }, ban: { one: 'ban', few: 'bani', other: 'de bani' },
                                                    lira: { one: 'liră', few: 'lire', other: 'de lire', gender: :female } })
      I18n.backend.store_translations(:el, units: { drachma: { one: 'δραχμή', other: 'δραχμές', gender: :female }, euro: 'ευρώ', cent: { one: 'λεπτό', other: 'λεπτά' } })
      I18n.backend.store_translations(:id, units: { rupiah: 'rupiah' })
      I18n.backend.store_translations(:az, units: { manat: 'manat', qapik: 'qəpik' })
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

    it 'spells Romanian with "de" before the unit from 20' do
      expect([2, 19, 20, 21, 101, 120].map { |number| words(:ro, number, unit: :leu) })
        .to eq(['doi lei', 'nouăsprezece lei', 'douăzeci de lei', 'douăzeci și unu de lei', 'o sută unu lei', 'o sută douăzeci de lei'])
      expect(words(:ro, 22, unit: :lira)).to eq('douăzeci și două de lire')
    end

    it 'spells Romanian decimals with the few form and amounts joined with și' do
      expect(words(:ro, 21.5, unit: :leu)).to eq('douăzeci și unu virgulă cinci lei')
      expect(words(:ro, 21.5, unit: :leu, subunit: :ban)).to eq('douăzeci și unu de lei și cincizeci de bani')
    end

    it 'spells Greek and Indonesian' do
      expect([1, 3, 200].map { |number| words(:el, number, unit: :drachma) }).to eq(['μία δραχμή', 'τρεις δραχμές', 'διακόσιες δραχμές'])
      expect(words(:id, 21, unit: :rupiah)).to eq('dua puluh satu rupiah')
      expect(words(:el, 21.5, unit: :euro, subunit: :cent)).to eq('είκοσι ένα ευρώ και πενήντα λεπτά')
    end

    it 'spells Azerbaijani with the singular unit and no subunit separator' do
      expect([1, 21, 2_000].map { |number| words(:az, number, unit: :manat) }).to eq(['bir manat', 'iyirmi bir manat', 'iki min manat'])
      expect(words(:az, 21.5, unit: :manat)).to eq('iyirmi bir tam onda beş manat')
      expect(words(:az, 21.5, unit: :manat, subunit: :qapik)).to eq('iyirmi bir manat əlli qəpik')
      expect(words(:az, 21, unit: :manat, ordinal: true)).to eq('iyirmi birinci manat')
    end

    it 'writes the unit without a space in languages written without spaces' do
      expect([words(:zh, 21, unit: :yuan), words(:th, 21, unit: :baht), words(:ja, 21, unit: :yen)]).to eq(%w[二十一元 ยี่สิบเอ็ดบาท 二十一円])
    end

    it 'writes a Korean unit after a space' do
      expect([words(:ko, 3, unit: :won), words(:ko, 12_345, unit: :won)]).to eq(['삼 원', '만 이천삼백사십오 원'])
    end

    it 'looks the unit up in the fallback locale' do
      available_locales = I18n.available_locales
      I18n.available_locales = available_locales | [:am]
      expect(words(:am, 3, unit: :dollar, fallback: :en)).to eq('three dollars')
    ensure
      I18n.available_locales = available_locales
    end
  end

  describe 'after a scale word' do
    before do
      I18n.backend.store_translations(:'pt-BR', units: { real: { one: 'real', other: 'reais' }, centavo: { one: 'centavo', other: 'centavos' } })
      I18n.backend.store_translations(:es, units: { euro: { one: 'euro', other: 'euros' }, centimo: { one: 'céntimo', other: 'céntimos' } })
      I18n.backend.store_translations(:it, units: { euro: 'euro', centesimo: { one: 'centesimo', other: 'centesimi' } })
      I18n.backend.store_translations(:'fr-CH', units: { franc: { one: 'franc', other: 'francs' } })
      I18n.backend.store_translations(:fr, units: { dollar: { one: 'dollar', other: 'dollars' }, ecu: { one: 'écu', other: 'écus' },
                                                    hectare: { one: 'hectare', other: 'hectares', elision: true },
                                                    hertz: { one: 'hertz', other: 'hertz' }, ohm: { one: 'ohm', other: 'ohms', elision: false } })
      I18n.backend.store_translations(:ro, units: { leu: { one: 'leu', few: 'lei', other: 'de lei' } })
    end

    it 'puts de before the unit in Brazilian Portuguese, only when the number ends in a scale word of a million or more' do
      expect([1_000_000, 2_000_000, 1_000_000_000, 3_000_000_000_000, -1_000_000].map { |number| words(:'pt-BR', number, unit: :real) })
        .to eq(['um milhão de reais', 'dois milhões de reais', 'um bilhão de reais', 'três trilhões de reais', 'menos um milhão de reais'])
      expect([1_000, 2_000, 1_000_100, 1_001_000, 21].map { |number| words(:'pt-BR', number, unit: :real) })
        .to eq(['mil reais', 'dois mil reais', 'um milhão e cem reais', 'um milhão e mil reais', 'vinte e um reais'])
    end

    it 'counts mil milhões as ending in a scale word in the European Portuguese long scale' do
      expect([1_000_000, 1_000_000_000, 2_000_000_000_000, 1_000_000_001].map { |number| words(:pt, number, unit: :euro) })
        .to eq(['um milhão de euros', 'mil milhões de euros', 'dois biliões de euros', 'mil milhões e um euros'])
    end

    it 'puts de before the unit in Spanish' do
      expect([1_000_000, 2_000_000, 1_000_000_000, 1_000_100, 1_000].map { |number| words(:es, number, unit: :euro) })
        .to eq(['un millón de euros', 'dos millones de euros', 'mil millones de euros', 'un millón cien euros', 'mil euros'])
    end

    it 'shortens a Spanish number before a masculine unit or subunit, and agrees with a feminine one' do
      I18n.backend.store_translations(:es, units: { peseta: { one: 'peseta', other: 'pesetas', gender: :female } })
      expect([words(:es, 2_000_000.01, unit: :euro, subunit: :centimo), words(:es, 21.21, unit: :euro, subunit: :centimo),
              words(:es, 101, unit: :euro), words(:es, 21, unit: :euro, ordinal: true), words(:es, 1.21, unit: :euro, subunit: :peseta),
              words(:es, 1, unit: :euro, apocopated: false), words(:es, 1.5, unit: :euro)])
        .to eq(['dos millones de euros con un céntimo', 'veintiún euros con veintiún céntimos', 'ciento un euros', 'vigésimo primer euro',
                'un euro con veintiuna pesetas', 'uno euro', 'uno con cinco décimas euros'])
    end

    it 'puts di before the unit in Italian' do
      expect([1_000_000, 2_000_000, 1_000_000_000, 1_000_100, 1_000].map { |number| words(:it, number, unit: :euro) })
        .to eq(['un milione di euro', 'due milioni di euro', 'un miliardo di euro', 'un milione cento euro', 'mille euro'])
    end

    it "elides de to d' before a vowel in French, and lets a unit choose for a word with h" do
      expect([words(:fr, 1_000_000, unit: :euro), words(:fr, 2_000_000, unit: :ecu), words(:fr, 2_000_000, unit: :dollar),
              words(:fr, 1_000_000_000, unit: :euro), words(:'fr-CH', 3_000_000, unit: :franc)])
        .to eq(["un million d'euros", "deux millions d'écus", 'deux millions de dollars', "un milliard d'euros", 'trois millions de francs'])
      expect([words(:fr, 2_000_000, unit: :hectare), words(:fr, 2_000_000, unit: :hertz), words(:fr, 2_000_000, unit: :ohm)])
        .to eq(["deux millions d'hectares", 'deux millions de hertz', 'deux millions de ohms'])
      expect([words(:fr, 1_000_100, unit: :euro), words(:fr, 1_000, unit: :euro)]).to eq(['un million cent euros', 'mille euros'])
    end

    it 'puts the preposition before the unit and not the subunit of an amount' do
      expect([words(:'pt-BR', 1_000_000.5, unit: :real, subunit: :centavo), words(:es, 2_000_000.25, unit: :euro, subunit: :centimo),
              words(:it, 1_000_000.5, unit: :euro, subunit: :centesimo), words(:fr, 1_000_000.5, unit: :euro, subunit: :centime),
              words(:'pt-BR', 1_000_100.5, unit: :real, subunit: :centavo)])
        .to eq(['um milhão de reais e cinquenta centavos', 'dos millones de euros con veinticinco céntimos', 'un milione di euro e cinquanta centesimi',
                "un million d'euros et cinquante centimes", 'um milhão e cem reais e cinquenta centavos'])
    end

    it 'leaves decimals, ordinals, zero and other languages unchanged' do
      expect([words(:'pt-BR', 1_000_000.5, unit: :real), words(:fr, 1_500_000.0, unit: :euro), words(:fr, 2_000_000.0, unit: :euro)])
        .to eq(['um milhão vírgula cinco reais', 'un million cinq-cent-mille euros', "deux millions d'euros"])
      expect([words(:es, 1_000_000, unit: :euro, ordinal: true), words(:'pt-BR', 0, unit: :real), words(:en, 1_000_000, unit: :dollar)])
        .to eq(['millonésimo euro', 'zero reais', 'one million dollars'])
    end

    it 'keeps the Romanian de, which comes from the unit forms' do
      expect([1_000, 1_000_000, 2_000_000, 1_000_100].map { |number| words(:ro, number, unit: :leu) })
        .to eq(['o mie de lei', 'un milion de lei', 'două milioane de lei', 'un milion o sută de lei'])
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

    it 'joins a European Portuguese subunit with e' do
      expect([words(:pt, 16.17, unit: :euro, subunit: :centimo), words(:pt, 1001.01, unit: :euro, subunit: :centimo)])
        .to eq(['dezasseis euros e dezassete cêntimos', 'mil e um euros e um cêntimo'])
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

    it 'starts negative amounts with the minus word, unless they round to zero' do
      expect([words(:en, -3.5, unit: :dollar, subunit: :cent), words(:en, -0.5, unit: :dollar, subunit: :cent, remove_zero: true),
              words(:en, -0.001, unit: :dollar, subunit: :cent)])
        .to eq(['minus three dollars and fifty cents', 'minus fifty cents', 'zero dollars'])
    end
  end

  it 'leaves numbers without a unit unchanged' do
    expect([words(:en, 21), words(:en, 1.5), words(:en, [1, 2])]).to eq(['twenty-one', 'one point five', %w[one two]])
  end
end
