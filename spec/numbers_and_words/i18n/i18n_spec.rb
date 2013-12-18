require 'spec_helper'

describe NumbersAndWords::I18n do

  describe '.local_language' do
    it 'checks validity of given language and return it as symbol' do
      expect(NumbersAndWords::I18n.local_language(:de)).to eq(:de)
    end

    context "when string given instead of symbol" do
      it "correctly normalizes it " do
        I18n.stub(:locale).and_return(" it ")
        expect(NumbersAndWords::I18n.local_language).to eq(:it)
      end
    end

    context "when no language given" do
      it "returns current I18n.locale" do
        I18n.stub(:locale).and_return(:it)
        expect(NumbersAndWords::I18n.local_language).to eq(:it)
      end
    end

    context "when unsupported language given" do
      it "raises error" do
        expect { NumbersAndWords::I18n.local_language("xxx") }.to raise_error("Language not supported")
      end
    end
  end
end
