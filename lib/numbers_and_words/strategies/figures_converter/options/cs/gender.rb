# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Cs
          class Gender < Base::Gender
            VALUES = %i[male female neuter].freeze

            def result
              active? ? @options[:gender].to_sym : :female
            end
          end
        end
      end
    end
  end
end
