# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.pt-BR.yml; see RuleSets.
        class PtBr < Base
          include RuleSets

          # remove_zero: true leaves no words for zero, also as an ordinal.
          def words
            ordinal_integer.zero? && @options.remove_zero.result ? '' : super
          end

          private

          # Inteiro and décimo are masculine whatever is counted ("dois inteiros e dois décimos").
          def cardinal_set
            @options.options[:fraction] && decimal_part? ? 'cardinal-male' : super
          end
        end
      end
    end
  end
end
