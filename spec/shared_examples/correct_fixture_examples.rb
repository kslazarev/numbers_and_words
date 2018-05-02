# frozen_string_literal: true

shared_examples 'correct fixture examples' do |examples|
  examples.each_pair do |method_name, context_names|
    context "##{method_name}" do
      context_names.each do |context_name, tests|
        options = tests.delete('options') || {}
        context context_with_options(context_name, options) do
          tests.each do |input, expectation|
            context input do
              subject { input.send method_name, options }
              it { is_expected.to eq(expectation) }
            end
          end
        end
      end
    end
  end
end

def context_with_options(name, options)
  name + (options.any? && " (#{options.inspect})" || '')
end
