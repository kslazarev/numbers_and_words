# frozen_string_literal: true

require 'spec_helper'

describe 'scale words' do # rubocop:disable RSpec/DescribeClass -- checks every bundled locale
  NumbersAndWords::I18n.languages.each do |locale|
    it "translates every scale in #{locale}" do
      I18n.with_locale(locale) do
        # Thai and Chinese have no list of scale words (Thai repeats ล้าน, Chinese composes 万 and 亿); check the same powers of a thousand.
        capacities = I18n.exists?('numbers.mega') ? I18n.t('numbers.mega').size - 1 : 6
        words = (1..capacities).flat_map { |capacity| [10**(3 * capacity), 2 * (10**(3 * capacity))].map(&:to_words) }
        expect(words.grep(/translation missing/i)).to eq([])
      end
    end
  end
end
