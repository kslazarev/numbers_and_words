# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Hi
          # gender: :male (the default) or :female, the gender of an ordinal (पहला or पहली).
          class Gender < Base::Gender
            VALUES = %i[male female].freeze
          end
        end
      end
    end
  end
end
