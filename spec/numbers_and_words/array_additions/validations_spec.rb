require 'spec_helper'

#describe NumbersAndWords::ArrayAdditions::Validations do
#  def figures str
#    str.split(//).tap { |a| a.extend described_class }
#  end
#
#  def validate_figures str
#    figures(str).tap { |f| f.validate_figure_array! }
#  end
#
#  it "validates an integer" do
#    expect { validate_figures "42" }.to_not raise_error
#  end
#
#  it "validates a float" do
#    expect { validate_figures "4.2" }.to_not raise_error
#  end
#
#  it "invalidates invalid characters" do
#    expect { validate_figures "1.2e+10" }.to raise_error("Figures may contain only numbers and `.` (invalid characters: e, +).")
#  end
#
#  it "invalidates multiple dots" do
#    expect { validate_figures "1.2.3" }.to raise_error("Figures may contain only 1 `.` (2 found).")
#  end
#end
