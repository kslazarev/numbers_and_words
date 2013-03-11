module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class En < Base
          include Families::Latin

          #include Extensions::Options::Fractional
          #include NumbersAndWords::Translations::En

          def union_elements elements, options = {}
            elements -= [zero]
            super
          end

          def complex_tens
            figures.ones ?
              translations.tens_with_ones(figures.tens_with_ones, hyphen_separator) :
              translations.tens(figures.tens)
          end

          def hundreds_number_to_words
            simple_number_to_words + union_after_hundreds([translations.hundreds(figures.hundreds)])
          end

          def hyphen_separator
            options.remove_hyphen.result
          end

          def union_after_hundreds translations
            options.hundreds_with_union.modify_or_leave translations
          end
        end
      end
    end
  end
end
