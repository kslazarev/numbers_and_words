module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module EnGb
          class Fractional < En::Fractional
            SHIFT_ZERO_LENGTH = 1

            def run
              fraction_to_digits
            end

            private

            def fraction_to_digits
              full_fraction.to_a.to_words.join ' '
            end

            def zero_length
              super - SHIFT_ZERO_LENGTH
            end
          end
        end
      end
    end
  end
end
