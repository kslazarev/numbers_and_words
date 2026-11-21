# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module He
          # Hebrew counts in the feminine form ("אחת, שתיים, שלוש"), so the gender defaults to female.
          class Gender < Base::Gender
            VALUES = %i[male female].freeze

            def result
              @options[:gender] ? @options[:gender].to_sym : :female
            end
          end
        end
      end
    end
  end
end
