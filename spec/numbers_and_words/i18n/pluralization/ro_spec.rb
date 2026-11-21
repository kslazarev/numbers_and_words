# frozen_string_literal: true

require 'spec_helper'

describe I18n, '#ro' do
  it 'pluralizes with "de" from 20' do
    forms = { one: 'one', few: 'few', other: 'other' }
    plurals = [0, 1, 2, 19, 20, 21, 100, 101, 119, 120, 1000].map { |count| described_class.backend.send(:pluralize, :ro, forms, count) }

    expect(plurals).to eq(%w[few one few few other other other few few other other])
  end
end
