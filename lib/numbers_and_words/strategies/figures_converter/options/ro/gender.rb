# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Ro
          # Romanian counts in the masculine form (unu, doi); neuter nouns take the masculine one and the
          # feminine two (un scaun, două scaune).
          class Gender < Base::Gender
            VALUES = %i[male female neuter].freeze
          end
        end
      end
    end
  end
end
