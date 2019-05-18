# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::Strategies::FiguresConverter::Options::Proxy do
  describe '#method_missing' do
    context 'when unexisting method called' do
      it 'rescues from NameError and returns nil' do
        proxy = described_class.new(double, {})
        expect(proxy.existing_method).to be_nil
      end
    end
  end
end
