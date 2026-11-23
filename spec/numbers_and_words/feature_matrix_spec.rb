# frozen_string_literal: true

require 'spec_helper'
require 'support/feature_matrix'

describe FeatureMatrix do
  it 'matches docs/features.md; run `bundle exec ruby script/features.rb` to update it' do
    expect(File.read(described_class::PAGE)).to eq(described_class.page)
  end
end
