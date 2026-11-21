# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class PtBr < Base
          %i[teens tens tens_with_ones].each do |method_name|
            define_method(method_name) do
              super(internal_options)
            end
          end

          def zero
            super unless maybe_remove_zero
          end

          def words
            super.strip
          end

          def complex_number_to_words
            super.compact
          end

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(current_capacity)
            words.push(megs) unless capacity_words.empty? || (capacity_words.empty? && figures[0] == 1)
            words + capacity_words
          end

          def ones
            super(internal_options.merge(is_one_thousand: one_thousand?))
          end

          def hundreds
            super(internal_options.merge(is_hundred: hundred?, is_one_hundred: one_hundred?, gender:))
          end

          def megs
            super(internal_options.merge(number: @figures.number_in_capacity(@current_capacity),
                                         is_opaque: opaque?,
                                         is_without_connector: without_connector?,
                                         is_with_comma: with_comma?))
          end

          private

          def internal_options
            { gender:, prefix: maybe_ordinal }
          end

          def maybe_ordinal
            @options.ordinal.result
          end

          # Milhão and larger scale nouns, and inteiro and décimo in fractions, are masculine whatever is counted
          # ("duas mil", but "dois milhões" and "dois inteiros e dois décimos").
          def gender
            return options.gender.result || :male if maybe_ordinal
            return :male if current_capacity.to_i > 1 || fraction_part?

            options.gender.result
          end

          def fraction_part?
            options.options[:fraction] && (options.options[:integral] || options.options[:fractional])
          end

          def hundred?
            figures[0].zero? && figures[1].zero? && simple_number_to_words.empty?
          end

          def one_hundred?
            hundred? && figures[2] == 1
          end

          def opaque?
            figures.opaque? current_capacity
          end

          # One is left out before mil, and before an ordinal scale word ("milionésimo", not "primeiro milionésimo").
          def one_thousand?
            (current_capacity == 1 || (maybe_ordinal && current_capacity.to_i > 1)) &&
              figures.ones == 1 &&
              figures.tens.nil? &&
              figures.hundreds.nil?
          end

          def without_connector?
            return false if with_comma?
            return true if figures.hundreds &&
                           (figures.tens_with_ones ||
                            figures.tens ||
                            figures.ones)

            false
          end

          def with_comma?
            return false unless @current_capacity > 1

            # a remainder below one hundred is joined with "e" ("um bilhão e vinte e um")
            number_under_capacity = figures.number_under_capacity(@current_capacity)
            return false if number_under_capacity < 100

            figures_under_capacity = figures.figures_array_under_capacity(@current_capacity)
            return false if figures_under_capacity.count(0) == (figures_under_capacity.size - 1)

            # else use comma
            true
          end

          def maybe_remove_zero
            @options.remove_zero.result
          end
        end
      end
    end
  end
end
