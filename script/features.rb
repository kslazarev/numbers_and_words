# frozen_string_literal: true

# Writes docs/features.md, the features of every bundled language (see spec/support/feature_matrix.rb).
#
#   bundle exec ruby script/features.rb

$LOAD_PATH.unshift File.expand_path('../lib', __dir__), File.expand_path('../spec', __dir__)

require 'numbers_and_words'
require 'support/feature_matrix'

File.write(FeatureMatrix::PAGE, FeatureMatrix.page)
puts "Wrote #{FeatureMatrix::PAGE}"
