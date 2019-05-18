# frozen_string_literal: true

require 'spec_helper'

describe I18n, '#cs' do
  it 'pluralizes correctly' do
    hash = {}
    %w[one few many other].each { |key| hash[key.to_sym] = key }

    expect(described_class.backend.send(:pluralize, :cs, hash, 1)).to eq('one')
    expect(described_class.backend.send(:pluralize, :cs, hash, 2)).to eq('few')
    expect(described_class.backend.send(:pluralize, :cs, hash, 3)).to eq('few')
    expect(described_class.backend.send(:pluralize, :cs, hash, 5)).to eq('many')
    expect(described_class.backend.send(:pluralize, :cs, hash, 10)).to eq('many')
    expect(described_class.backend.send(:pluralize, :cs, hash, 11)).to eq('many')
    expect(described_class.backend.send(:pluralize, :cs, hash, 21)).to eq('one')
    expect(described_class.backend.send(:pluralize, :cs, hash, 29)).to eq('many')
    expect(described_class.backend.send(:pluralize, :cs, hash, 52)).to eq('few')
    expect(described_class.backend.send(:pluralize, :cs, hash, 131)).to eq('one')
    expect(described_class.backend.send(:pluralize, :cs, hash, 1.31)).to eq('other')
    expect(described_class.backend.send(:pluralize, :cs, hash, 2.31)).to eq('other')
    expect(described_class.backend.send(:pluralize, :cs, hash, 3.31)).to eq('other')
  end
end
