# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Nb
          # Norwegian Bokmål counts with the masculine "en", so the gender defaults to male; female gives "ei" and neuter "ett".
          class Gender < Base::Gender
            VALUES = %i[male female neuter].freeze
          end
        end
      end
    end
  end
end
