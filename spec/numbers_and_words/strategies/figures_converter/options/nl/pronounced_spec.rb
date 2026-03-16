# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Options::Nl::Pronounced do
  it 'pronounce dutch numbers' do
    expect(I18n.with_locale(:nl) { 1100.to_words(pronounced: true) }).to eq("elfhonderd")
    expect(I18n.with_locale(:nl) { 1101.to_words(pronounced: true) }).to eq("elfhonderd een")
    expect(I18n.with_locale(:nl) { 1103.to_words(pronounced: true) }).to eq("elfhonderd drie")
    expect(I18n.with_locale(:nl) { 1111.to_words(pronounced: true) }).to eq("elfhonderd elf")
    expect(I18n.with_locale(:nl) { 2000.to_words(pronounced: true) }).to eq("twee duizend")
    expect(I18n.with_locale(:nl) { 2001.to_words(pronounced: true) }).to eq("twee duizend een")
    expect(I18n.with_locale(:nl) { 2003.to_words(pronounced: true) }).to eq("twee duizend drie")
    expect(I18n.with_locale(:nl) { 3000.to_words(pronounced: true) }).to eq("drie duizend")
    expect(I18n.with_locale(:nl) { 3001.to_words(pronounced: true) }).to eq("drie duizend een")
    expect(I18n.with_locale(:nl) { 3013.to_words(pronounced: true) }).to eq("drie duizend dertien")
  end
end
