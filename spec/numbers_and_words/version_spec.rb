# frozen_string_literal: true

require 'spec_helper'

describe NumbersAndWords::VERSION do
  let(:version_array) { subject.split '.' }
  let(:version_sum) { version_array.sum(&:to_i) }

  it { expect(version_array).not_to be_empty }
  it { expect(version_array.size).to eq 3 }
  it { expect(version_sum).not_to eq(0) }
end
