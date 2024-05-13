# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::I18n do
  describe '.local_language' do
    it 'checks validity of given language and return it as symbol' do
      expect(described_class.local_language(:de)).to eq(:de)
    end

    context 'when string given instead of symbol' do
      it 'correctly normalizes it' do
        allow(I18n).to receive(:locale).and_return(' it ')
        expect(described_class.local_language).to eq(:it)
      end
    end

    context 'when no language given' do
      it 'returns current I18n.locale' do
        allow(I18n).to receive(:locale).and_return(:it)
        expect(described_class.local_language).to eq(:it)
      end
    end

    context 'when unsupported language given' do
      it 'raises error' do
        expect { described_class.local_language('xxx') }.to raise_error('Language not supported')
      end
    end
  end
end
