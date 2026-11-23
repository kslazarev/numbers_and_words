# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::I18n do
  describe '.cached' do
    after { I18n.reload! }

    def count_calls(times)
      calls = 0
      times.times { described_class.cached(:spec, :key) { calls += 1 } }
      calls
    end

    it 'derives a value once while the Simple backend keeps its translations' do
      expect(count_calls(3)).to eq(1)
    end

    it 'keeps nil' do
      calls = 0
      2.times { described_class.cached(:spec, :nil) { (calls += 1) && nil } }
      expect(calls).to eq(1)
    end

    it 'derives the value again after the backend stores or reloads translations' do
      count_calls(1)
      I18n.backend.store_translations(:en, numbers: {})
      expect(count_calls(1)).to eq(1)
      I18n.reload!
      expect(count_calls(1)).to eq(1)
    end

    it 'derives the value each time with another backend' do
      simple = I18n.backend
      I18n.backend = I18n::Backend::Chain.new(simple)
      expect(count_calls(2)).to eq(2)
      I18n.with_locale(:en) { expect(42.to_words).to eq('forty-two') }
    ensure
      I18n.backend = simple
    end
  end

  describe '.t' do
    after { I18n.reload! }

    it 'looks up a translation with a count each time' do
      I18n.with_locale(:en) do
        expect(described_class.t('numbers.mega', count: 1)).to eq(I18n.t('numbers.mega', count: 1))
        allow(I18n).to receive(:t).and_call_original
        2.times { described_class.t('numbers.mega', count: 1) }
        expect(I18n).to have_received(:t).twice
      end
    end

    it 'returns a translation stored after it was first looked up' do
      I18n.with_locale(:en) do
        expect(described_class.t('numbers.minus')).to eq('minus')
        I18n.backend.store_translations(:en, numbers: { minus: 'negative' })
        expect(described_class.t('numbers.minus')).to eq('negative')
        expect(-1.to_words).to eq('negative one')
      end
    end
  end
end
