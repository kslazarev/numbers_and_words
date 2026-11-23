# frozen_string_literal: true

require 'spec_helper'

describe I18n, '#pl' do
  {
    one: [1, -1],
    few: [2, 3, 4, 22, 24, 102],
    many: [0, 5, 10, 11, 12, 14, 21, 31, 101, 112, 131],
    other: [1.0, 1.31, 2.31]
  }.each do |form, numbers|
    numbers.each do |number|
      it "uses #{form} for #{number.inspect}" do
        expect(NumbersAndWords::I18n::Pluralization.rule(:pl).call(number)).to eq(form)
      end
    end
  end

  it 'integrates compound-one pluralization with the I18n backend' do
    expect(described_class.t('numbers.thousands', locale: :pl, count: 21)).to eq('tysięcy')
  end
end
