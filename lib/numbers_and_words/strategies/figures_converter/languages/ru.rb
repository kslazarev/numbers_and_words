# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Ru < Base
          # remove_zero: true omits a zero integral part.
          def zero(*args)
            super unless @options.remove_zero.result
          end

          include Families::Cyrillic
        end
      end
    end
  end
end
