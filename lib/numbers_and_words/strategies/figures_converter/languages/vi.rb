# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.vi.yml; see RuleSets. A fractional part keeps its
        # leading zeros ("không năm").
        class Vi < Base
          include RuleSets

          def words
            return super unless fractional?

            zeros = [@translations.t(:ones)[0]] * (@options.options[:fractional][:length] - @figures.length)
            [*zeros, super].reject(&:empty?).join(' ')
          end

          private

          def fractional?
            !@options.options[:fractional].nil? && !@options.options[:integral]
          end
        end
      end
    end
  end
end
