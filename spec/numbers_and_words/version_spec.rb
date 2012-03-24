require './spec/spec_helper'

describe NumbersAndWords do
  context "version" do
    it "exists" do
      NumbersAndWords::VERSION.length.should > 0
    end
    it "has 3 parts" do
      NumbersAndWords::VERSION.split(".").length.should == 3
    end
    it "is not zero" do
      NumbersAndWords::VERSION.split(".").inject(0) { |sum, part| sum + part.to_i }.should > 0
    end
  end
end
