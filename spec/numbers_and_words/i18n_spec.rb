require 'spec_helper'

describe I18n do
  context "load_path" do
    it "initializes a flat path" do
      # I18n.load_path is an array, Rails 3.x will choke on start
      I18n.load_path.flatten.should == I18n.load_path
    end
  end
end
