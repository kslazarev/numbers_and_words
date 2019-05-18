# frozen_string_literal: true

require 'spec_helper'

describe I18n, '#ru' do
  it 'pluralizes correctly' do
    hash = {}
    %w[one few many other].each { |key| hash[key.to_sym] = key }

    expect(described_class.backend.send(:pluralize, :ru, hash, 1)).to eq('one')
    expect(described_class.backend.send(:pluralize, :ru, hash, 2)).to eq('few')
    expect(described_class.backend.send(:pluralize, :ru, hash, 3)).to eq('few')
    expect(described_class.backend.send(:pluralize, :ru, hash, 5)).to eq('many')
    expect(described_class.backend.send(:pluralize, :ru, hash, 10)).to eq('many')
    expect(described_class.backend.send(:pluralize, :ru, hash, 11)).to eq('many')
    expect(described_class.backend.send(:pluralize, :ru, hash, 21)).to eq('one')
    expect(described_class.backend.send(:pluralize, :ru, hash, 29)).to eq('many')
    expect(described_class.backend.send(:pluralize, :ru, hash, 131)).to eq('one')
    expect(described_class.backend.send(:pluralize, :ru, hash, 1.31)).to eq('other')
    expect(described_class.backend.send(:pluralize, :ru, hash, 2.31)).to eq('other')
    expect(described_class.backend.send(:pluralize, :ru, hash, 3.31)).to eq('other')
  end
end
