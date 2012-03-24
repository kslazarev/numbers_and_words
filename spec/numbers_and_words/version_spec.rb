require 'spec_helper'

describe NumbersAndWords::VERSION, 'version' do
  let(:version_array) { subject.split '.' }
  let(:version_sum) { version_array.map(&:to_i).reduce :+ }

  it { version_array.should_not be_empty }
  it { version_array.should have(3).items }
  it { version_sum.should_not be == 0 }
end
