# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # British English says "and" after hundreds and before a last group below a hundred by default ("one hundred
        # and one", "one thousand and one").
        class EnGb < En
          private

          def union?
            @options.options.fetch(:hundreds_with_union, true)
          end
        end
      end
    end
  end
end
