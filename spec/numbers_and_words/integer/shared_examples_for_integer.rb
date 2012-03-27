shared_examples 'correct examples' do
  subject.call.each do |context_name, tests|
    context context_name do
      tests.each do |input, expectation|
        context input do
          subject { input.send method_name }
          it { should == expectation }
        end
      end
    end
  end
end
