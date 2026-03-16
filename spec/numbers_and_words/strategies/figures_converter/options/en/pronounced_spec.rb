# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Options::En::Pronounced do
  it 'pronounce english numbers' do
    expect(I18n.with_locale(:en) { 1100.to_words(pronounced: true) }).to eq('eleven hundred')
    expect(I18n.with_locale(:en) { 1101.to_words(pronounced: true) }).to eq('eleven hundred one')
    expect(I18n.with_locale(:en) { 1103.to_words(pronounced: true) }).to eq('eleven hundred three')
    expect(I18n.with_locale(:en) { 1111.to_words(pronounced: true) }).to eq('eleven hundred eleven')
    expect(I18n.with_locale(:en) { 2000.to_words(pronounced: true) }).to eq('two thousand')
    expect(I18n.with_locale(:en) { 2001.to_words(pronounced: true) }).to eq('two thousand one')
    expect(I18n.with_locale(:en) { 2003.to_words(pronounced: true) }).to eq('two thousand three')
    expect(I18n.with_locale(:en) { 3000.to_words(pronounced: true) }).to eq('three thousand')
    expect(I18n.with_locale(:en) { 3001.to_words(pronounced: true) }).to eq('three thousand one')
    expect(I18n.with_locale(:en) { 3013.to_words(pronounced: true) }).to eq('three thousand thirteen')
  end
end
