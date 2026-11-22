# frozen_string_literal: true

require 'spec_helper'

# Chinese, Japanese and Korean share the grouping by ten thousands (Languages::Myriad); the fixtures check
# their words, and this checks the limits of the shared grouping.
describe NumbersAndWords::Strategies::FiguresConverter::Languages::Myriad do
  { ja: %w[一極 九千九百九十九極], ko: %w[일극 구천구백구십구극] }.each do |locale, (smallest, largest)|
    context "with #{locale}" do
      around { |example| I18n.with_locale(locale) { example.run } }

      it 'names every scale up to 10^48' do
        expect((10**48).to_words).to eq(smallest)
        expect(((10**52) - 1).to_words).to start_with(largest)
      end

      it 'raises RangeError beyond the largest scale' do
        expect { (10**52).to_words }.to raise_error(RangeError, /10\^52/)
      end
    end
  end

  it 'composes Chinese scales without a limit' do
    expect(I18n.with_locale(:zh) { (10**52).to_words }).to eq('一万亿亿亿亿亿亿')
  end

  it 'rejects an unknown Japanese script' do
    expect { I18n.with_locale(:ja) { 1.to_words(script: :romaji) } }
      .to raise_error(NumbersAndWords::UnsupportedOptionError, /:script is not supported in :ja; supported: :kanji, :kana/)
  end

  it 'accepts the Japanese script as a string' do
    expect(I18n.with_locale(:ja) { [300.to_words(script: 'kana'), 1.5.to_words(script: 'kana')] }).to eq(%w[さんびゃく いってんご])
  end
end
