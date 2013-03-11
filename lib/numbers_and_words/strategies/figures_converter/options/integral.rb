module NumbersAndWords
  module Strategies
    module Extensions
      module Options
        module Integral

          private

          def print_format
            integral? ? [print_words, integral_word].join(' ') : super
          end

          def integral?
            options[:print_format] == :integral
          end

          def integral_word
            translate_integral_word figures.reverse.join.to_i
          end
        end
      end
    end
  end
end
