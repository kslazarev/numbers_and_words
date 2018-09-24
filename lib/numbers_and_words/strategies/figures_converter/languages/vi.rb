# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Vi < Base
          def print_words
            value = super
            remove_billion_noice(value)
          end

          def strings_logic
            if fractional?
              if fraction_number_zeros_leading.zero?
                @options.options[:integeral] = true
                integeral_string_logic
              else
                fractional_with_zero_leading_string_logic
              end
            else
              integeral_string_logic
            end
          end

          def fractional_with_zero_leading_string_logic
            leading_zeros = [0] * fraction_number_zeros_leading
            (@figures + leading_zeros).map(&:to_words)
          end

          def integeral_string_logic
            if @figures.capacity_count
              number_without_capacity_to_words + complex_number_to_words
            elsif hundreds?
              hundreds_number_to_words
            elsif @figures.tens || @figures.ones
              simple_number_to_words
            else
              []
            end
          end

          def hundreds?
            @figures.hundreds ||
              (@figures.size == 3 && (@figures.teens || @figures.tens || @figures.ones))
          end

          def hundreds(options = {})
            if @figures.hundreds.to_i.zero?
              translate :hundreds, 0, options
            else
              super
            end
          end

          def ones(options = {})
            if @figures.capacity_length >= 2
              ones_union(options)
            else
              super
            end
          end

          def ones_union(options = {})
            translate :ones_union, @figures.ones, options
          end

          def fractional?
            !@options.options[:fractional].nil? && !@options.options[:integeral]
          end

          def fraction_length
            return 0 unless @options.options[:fractional]

            @options.options[:fractional][:length]
          end

          def fraction_number_zeros_leading
            fraction_length - @figures.length
          end

          def remove_billion_noice(value)
            parts = value.split(billion_unit).map(&:strip)
            if value.end_with?(billion_unit)
              parts.insert(-1, billion_unit).join(' ')
            else
              return value if parts.size <= 2

              parts.insert(-2, billion_unit).join(' ')
            end
          end

          def billion_unit
            translate :mega, 3
          end
        end
      end
    end
  end
end
