# frozen_string_literal: true

require 'spec_helper'

# YAML keeps only the last of repeated keys, which would silently skip fixture examples.
describe 'fixture files' do # rubocop:disable RSpec/DescribeClass -- checks YAML files, not a class
  def key_name(key)
    key.is_a?(Psych::Nodes::Scalar) ? key.value.delete('_') : key.to_ruby.inspect
  end

  def duplicate_keys(node, path = [])
    return [] unless node.is_a?(Psych::Nodes::Mapping)

    pairs = node.children.each_slice(2).map { |key, value| [key_name(key), value] }
    repeated(pairs.map(&:first)).map { |key| (path + [key]).join('/') } +
      pairs.flat_map { |key, value| duplicate_keys(value, path + [key]) }
  end

  def repeated(keys)
    keys.tally.select { |_, count| count > 1 }.keys
  end

  Dir[File.expand_path('*/fixture_examples/*.yml', __dir__)].each do |path|
    it "has no duplicate keys in #{path.split('/').last(3).join('/')}" do
      expect(duplicate_keys(Psych.parse_file(path).root)).to eq([])
    end
  end
end
