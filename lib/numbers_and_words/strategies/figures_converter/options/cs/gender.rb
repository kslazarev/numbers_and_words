# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Cs
          class Gender < Base::Gender
            VALUES = %i[male female neuter].freeze

            # Without gender: numbers use the counting forms (jedna, dva, tři), which only cardinals have.
            def result
              active? ? @options[:gender].to_sym : :counting
            end
          end
        end
      end
    end
  end
end
