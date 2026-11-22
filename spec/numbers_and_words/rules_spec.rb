# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Rules do
  subject(:rules) { described_class.new(translations, 9) }

  let(:translations) do
    data = {
      ones: %w[zero one two three four five six seven eight nine],
      short_ones: %w[zero a two three four five six seven eight nine],
      teens: %w[_ eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen],
      tens: %w[_ ten twenty thirty forty fifty sixty seventy eighty ninety],
      thousands: { one: 'thousand', other: 'thousands' },
      hundred: 'hundred',
      rules: {
        cardinal: {
          0 => '{ones}',
          10 => '{tens}',
          11 => '{teens%}',
          20 => '{tens}[-{>}]',
          100 => '{<} hundred[ and {>}]',
          1000 => '{<short} {thousands}[ {>}]'
        },
        short: { extends: 'cardinal', 0 => '{short_ones}' },
        ordinal: { 0 => '{ordinals}', 20 => '[{tens}-{>}|{ordinal_tens}]', 100 => '{<cardinal} hundred[ {>}|th]' },
        counting: { extends: 'cardinal', then: 'counted', 1 => 'just one', 2 => '{ones}' },
        counted: { extends: 'cardinal', 1 => 'one more', 2 => '{ones}' },
        word: { extends: 'cardinal', 100 => '{<} {hundred}[ {>}]' }
      },
      ordinals: %w[zeroth first second third fourth fifth sixth seventh eighth ninth],
      ordinal_tens: %w[_ tenth twentieth thirtieth fortieth fiftieth sixtieth seventieth eightieth ninetieth],
      loud: { tens: %w[_ TEN TWENTY THIRTY FORTY FIFTY SIXTY SEVENTY EIGHTY NINETY] }
    }
    Class.new do
      define_method(:t) do |key, options = {}|
        value = key.to_s.split('.').reduce(data) { |hash, part| hash&.dig(part.to_sym) }
        if value.is_a?(Hash) && options.key?(:count)
          value[options[:count] == 1 ? :one : :other]
        else
          value
        end
      end
    end.new
  end

  it 'looks up words by the quotient, or by the remainder with %' do
    expect([7, 10, 13, 40].map { |number| rules.spell(number, 'cardinal') }).to eq(%w[seven ten thirteen forty])
  end

  it 'spells the quotient and the remainder, with optional parts only when the remainder is not zero' do
    expect([42, 300, 305].map { |number| rules.spell(number, 'cardinal') }).to eq(['forty-two', 'three hundred', 'three hundred and five'])
  end

  it 'chooses the plural form of a scale word and spells the quotient with another rule set' do
    expect([1000, 2001].map { |number| rules.spell(number, 'cardinal') }).to eq(['a thousand', 'two thousands one'])
  end

  it 'inherits the rules of an extended rule set and overrides some' do
    expect([1, 2, 21].map { |number| rules.spell(number, 'short') }).to eq(%w[a two twenty-a])
  end

  it 'chooses between two parts by whether the remainder is zero' do
    expect([20, 23, 300, 305].map { |number| rules.spell(number, 'ordinal') })
      .to eq(['twentieth', 'twenty-third', 'three hundredth', 'three hundred fifth'])
  end

  it 'spells the remainder with the rule set named by then' do
    expect([1, 21, 1021].map { |number| rules.spell(number, 'counting') })
      .to eq(['just one', 'twenty-one more', 'a thousand twenty-one more'])
  end

  it 'spells a single word as it is' do
    expect([100, 342].map { |number| rules.spell(number, 'word') }).to eq(['one hundred', 'three hundred forty-two'])
  end

  it 'looks words up under the words scope first, then at the top level' do
    expect(described_class.new(translations, 9, words: 'loud').spell(42, 'cardinal')).to eq('FORTY-two')
  end

  it 'raises RangeError past the limit' do
    expect { rules.spell(10**9, 'cardinal') }.to raise_error(RangeError, /numbers must be below 10\*\*9/)
  end
end
