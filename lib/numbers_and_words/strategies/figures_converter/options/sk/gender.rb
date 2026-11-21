# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Sk
          # Slovak numbers default to the masculine form ("jeden", "dva"); female gives "jedna", "dve" and neuter "jedno", "dve".
          class Gender < Base::Gender
            VALUES = %i[male female neuter].freeze
          end
        end
      end
    end
  end
end
