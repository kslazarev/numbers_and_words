# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Pl
          class Gender < Base::Gender
            def result
              gender = (@options[:gender] || :male).to_s.to_sym
              raise ArgumentError, 'Polish gender must be male, female or neuter' unless %i[male female neuter].include?(gender)

              gender
            end
          end
        end
      end
    end
  end
end
