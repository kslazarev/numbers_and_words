module NumbersAndWords
  module Strategies
    module Extensions
      module Options
        module Fractional

          private

          def before_convert
            if fractional?
              options[:fraction_length] += shift_fraction_length
              shift_fraction_length.times { figures.unshift 0 }
            end
            super
          end

          def print_format
            fractional? ? [print_words, fraction_significance].join(' ') : super
          end

          def before_union_elements
            separator = options[:fractional_separator] || translation_fraction_separator(options)
            options[:union_separator] = separator
            super
          end

          def fraction_significance
            translation_micros full_fraction.fraction_capacity, figures.reverse.join.to_i
          end

          def full_fraction
            (0..zero_length).inject(figures.clone) { |result| result.unshift '0' }.to_figures
          end

          def zero_length
            fraction_length - figures.length
          end

          def fractional?
            options[:print_format] == :fractional
          end

          def zero_with_fraction?
            options[:zero_with_fraction]
          end

          def fraction_length
            options[:fraction_length]
          end

          def shift_fraction_length
            options[:shift_fraction_length].to_i
          end
        end
      end
    end
  end
end
