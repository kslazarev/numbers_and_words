# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::I18n::Initialization do
  context '.init' do
    it 'initializes a flat path' do
      # I18n.load_path is an array, Rails 3.x will choke on start
      expect(I18n.load_path.flatten).to eq(I18n.load_path)
    end
  end
end
