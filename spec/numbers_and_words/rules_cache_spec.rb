# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Rules do
  after { I18n.reload! }

  it 'spells with words stored after the rules were compiled' do
    I18n.with_locale(:en) do
      expect(42.to_words).to eq('forty-two')
      I18n.backend.store_translations(:en, numbers: { tens: %w[_ ten twenty thirty FORTY fifty sixty seventy eighty ninety] })
      expect(42.to_words).to eq('FORTY-two')
    end
  end

  it 'spells with rules stored after the rules were compiled' do
    I18n.with_locale(:en) do
      expect(7.to_words).to eq('seven')
      I18n.backend.store_translations(:en, numbers: { rules: { cardinal: { 0 => '<{ones}>' } } })
      expect(7.to_words).to eq('<seven>')
    end
  end

  it 'compiles again for rules that are not the ones it compiled' do
    I18n.with_locale(:en) do
      compiled = described_class.compiled(NumbersAndWords::Translations::En.new)
      I18n.reload!
      expect(described_class.compiled(NumbersAndWords::Translations::En.new)).not_to equal(compiled)
    end
  end
end
