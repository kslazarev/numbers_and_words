require 'spec_helper'

describe Integer do
  around(:each) { |example| I18n.with_locale(:en) { example.run } }

  [ 
    {
      :ones => [
        [ 0, "zero" ],
        [ 1, "one" ],
        [ 9, "nine" ],
      ]
    },
    {
      :teens => [
        [ 10, "ten" ],
        [ 11, "eleven" ],
        [ 19, "nineteen" ],
        [ 20, "twenty" ],
        [ 21, "twenty-one" ],
        [ 90, "ninety" ],
        [ 99, "ninety-nine" ],
      ]
    },
    {
      :hundreds => [
        [ 100, "one hundred" ],
        [ 101, "one hundred one" ],
        [ 111, "one hundred eleven" ],
        [ 120, "one hundred twenty" ],
        [ 121, "one hundred twenty-one" ],
        [ 900, "nine hundred" ],
        [ 909, "nine hundred nine" ],
        [ 919, "nine hundred nineteen" ],
        [ 990, "nine hundred ninety" ],
        [ 999, "nine hundred ninety-nine" ],
      ]
    },
    {
      :thousands => [
        [ 1000, "one thousand" ],
        [ 21000, "twenty-one thousand" ],
        [ 2000, "two thousand" ],
        [ 4000, "four thousand" ],
        [ 5000, "five thousand" ],
        [ 11000, "eleven thousand" ],
        [ 999000, "nine hundred ninety-nine thousand" ],
        [ 999999, "nine hundred ninety-nine thousand nine hundred ninety-nine" ],
      ],
    },
    {
      :millions => [
        [ 1000000, "one million" ],
        [ 2000000, "two million" ],
        [ 4000000, "four million" ],
        [ 5000000, "five million" ],
        [ 999000000, "nine hundred ninety-nine million" ],
        [ 999000999, "nine hundred ninety-nine million nine hundred ninety-nine" ],
        [ 999999000, "nine hundred ninety-nine million nine hundred ninety-nine thousand" ],
        [ 999999999, "nine hundred ninety-nine million nine hundred ninety-nine thousand nine hundred ninety-nine" ],
      ],
    },
    {
      :billions => [
        [ 1174315119, "one billion one hundred seventy-four million three hundred fifteen thousand one hundred nineteen" ],
        [ 15174315119, "fifteen billion one hundred seventy-four million three hundred fifteen thousand one hundred nineteen" ],
        [ 35174315119, "thirty-five billion one hundred seventy-four million three hundred fifteen thousand one hundred nineteen" ],
        [ 935174315119, "nine hundred thirty-five billion one hundred seventy-four million three hundred fifteen thousand one hundred nineteen" ],
      ],
    },
    {
      :trillions => [
        [ 2935174315119, "two trillion nine hundred thirty-five billion one hundred seventy-four million three hundred fifteen thousand one hundred nineteen" ],
      ]
    }
  ].each do |ctx|
    ctx.each_pair do |range, tests|
      context range do
        tests.each do |test|
          it test[0] do
            test[0].to_words.should == test[1]
          end
        end
      end
    end
  end
end

