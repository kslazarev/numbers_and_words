require './spec/spec_helper'

describe Integer do
  around :each do |example|
    I18n.with_locale(:ru) do
      example.run
    end
  end

  describe '#to_words' do
    describe 'ones' do
      context '0 as uniq example' do
        subject { 0 }
        its(:to_words) { should == t(:ones_male)[0] }
      end

      context '1 as lower example' do
        subject { 1 }
        its(:to_words) { should == t(:ones_male)[1] }
      end

      context '9 as upper example' do
        subject { 9 }
        its(:to_words) { should == t(:ones_male)[9] }
      end
    end

    describe 'teens' do
      context '10 as uniq example' do
        subject { 10 }
        its(:to_words) { should == t(:teens)[0] }
      end

      context '11 as lower example' do
        subject { 11 }
        its(:to_words) { should == t(:teens)[1] }
      end

      context '19 as upper example' do
        subject { 19 }
        its(:to_words) { should == t(:teens)[9] }
      end
    end

    describe 'tens' do
      context '20 as lower example' do
        subject { 20 }
        its(:to_words) { should == t(:tens)[2] }
      end

      context '21 as lower example with ones' do
        subject { 21 }
        its(:to_words) { should == [t(:tens)[2], t(:ones_male)[1]].join(' ') }
      end

      context '90 as upper example' do
        subject { 90 }
        its(:to_words) { should == t(:tens)[9] }
      end

      context '99 as upper example with ones' do
        subject { 99 }
        its(:to_words) { should == [t(:tens)[9], t(:ones_male)[9]].join(' ') }
      end
    end

    describe 'hundreds' do
      context '100 as lower example' do
        subject { 100 }
        its(:to_words) { should == t(:hundreds)[1] }
      end

      context '101 as lower example with ones' do
        subject { 101 }
        its(:to_words) { should == [t(:hundreds)[1], t(:ones_male)[1]].join(' ') }
      end

      context '111 as lower example with teens' do
        subject { 111 }
        its(:to_words) { should == [t(:hundreds)[1], t(:teens)[1]].join(' ') }
      end

      context '120 as lower example with tens' do
        subject { 120 }
        its(:to_words) { should == [t(:hundreds)[1], t(:tens)[2]].join(' ') }
      end

      context '121 as lower example with tens and ones' do
        subject { 121 }

        its(:to_words) { should == [
          t(:hundreds)[1],
          t(:tens)[2],
          t(:ones_male)[1]
        ].join(' ') }
      end

      context '900 as upper example' do
        subject { 900 }
        its(:to_words) { should == t(:hundreds)[9] }
      end

      context '909 as upper example with ones' do
        subject { 909 }
        its(:to_words) { should == [t(:hundreds)[9], t(:ones_male)[9]].join(' ') }
      end

      context '919 as upper example with teens' do
        subject { 919 }
        its(:to_words) { should == [t(:hundreds)[9], t(:teens)[9]].join(' ') }
      end

      context '990 as upper example with tens' do
        subject { 990 }
        its(:to_words) { should == [t(:hundreds)[9], t(:tens)[9]].join(' ') }
      end

      context '999 as upper example with tens and ones' do
        subject { 999 }

        its(:to_words) { should == [t(:hundreds)[9], t(:tens)[9], t(:ones_male)[9]].
          join(' ') }
      end
    end

    describe 'thousands' do
      describe 'one' do
        context '1000 as uniq example' do
          subject { 1000 }

          its(:to_words) { should == [t(:ones_female)[1], t(:thousands, :count => 1)].
            join(' ') }
        end

        context '21000 as uniq example' do
          subject { 21000 }

          its(:to_words) { should == [
            t(:tens)[2], t(:ones_female)[1], t(:thousands, :count => 1)
          ].join(' ') }
        end
      end

      describe 'few' do
        context '2000 as lower example' do
          subject { 2000 }

          its(:to_words) { should == [t(:ones_female)[2], t(:thousands, :count => 2)].
            join(' ') }
        end

        context '4000 as upper example' do
          subject { 4000 }

          its(:to_words) { should == [t(:ones_female)[4], t(:thousands, :count => 4)].
            join(' ') }
        end
      end

      describe 'many' do
        context '5000 as lower example' do
          subject { 5000 }

          its(:to_words) { should == [t(:ones_female)[5], t(:thousands, :count => 5)].
            join(' ') }
        end

        context '11000 as uniq example' do
          subject { 11000 }

          its(:to_words) { should == [t(:teens)[1], t(:thousands, :count => 11)].join(' ') }
        end

        context '999000 as upper example' do
          subject { 999000 }

          its(:to_words) { should == [t(:hundreds)[9],
            t(:tens)[9],
            t(:ones_female)[9],
            t(:thousands, :count => 999)
          ].join(' ') }
        end
      end

      describe 'custom' do
        context '999999 as example with first capacity' do
          subject { 999999 }

          its(:to_words) { should == [t(:hundreds)[9],
            t(:tens)[9],
            t(:ones_female)[9],
            t(:thousands, :count => 999),
            t(:hundreds)[9],
            t(:tens)[9],
            t(:ones_male)[9],
          ].join(' ') }
        end
      end
    end
  end

  describe 'millions' do
    describe 'one' do
      context '1000000 as uniq example' do
        subject { 1000000 }

        its(:to_words) { should == [t(:ones_male)[1], t(:millions, :count => 1)].
          join(' ') }
      end
    end

    context 'few' do
      context '2000000 as lower example in few' do
        subject { 2000000 }

        its(:to_words) { should == [t(:ones_male)[2], t(:millions, :count => 2)].
          join(' ') }
      end

      context '4000000 as upper example in few' do
        subject { 4000000 }

        its(:to_words) { should == [t(:ones_male)[4], t(:millions, :count => 4)].
          join(' ') }
      end
    end

    context 'many' do
      context '5000000 as lower example in many' do
        subject { 5000000 }

        its(:to_words) { should == [t(:ones_male)[5], t(:millions, :count => 5)].
          join(' ') }
      end

      context '99900000 as upper example' do
        subject { 999000000 }

        its(:to_words) { should == [t(:hundreds)[9],
          t(:tens)[9],
          t(:ones_male)[9],
          t(:millions, :count => 999)
        ].join(' ') }
      end
    end

    context 'custom' do
      context '999000999 as example with first capacity' do
        subject { 999000999 }

        its(:to_words) { should == [t(:hundreds)[9],
          t(:tens)[9],
          t(:ones_male)[9],
          t(:millions, :count => 999),
          t(:hundreds)[9],
          t(:tens)[9],
          t(:ones_male)[9],
        ].join(' ') }
      end

      context '999999000 as example with second capacity' do
        subject { 999999000 }

        its(:to_words) { should == [t(:hundreds)[9],
          t(:tens)[9],
          t(:ones_male)[9],
          t(:millions, :count => 999),
          t(:hundreds)[9],
          t(:tens)[9],
          t(:ones_female)[9],
          t(:thousands, :count => 999),
        ].join(' ') }
      end

      context '999999999 as example with first and second capacity' do
        subject { 999999999 }

        its(:to_words) { should == [t(:hundreds)[9],
          t(:tens)[9],
          t(:ones_male)[9],
          t(:millions, :count => 999),
          t(:hundreds)[9],
          t(:tens)[9],
          t(:ones_female)[9],
          t(:thousands, :count => 999),
          t(:hundreds)[9],
          t(:tens)[9],
          t(:ones_male)[9],
        ].join(' ') }
      end
    end
  end
end
