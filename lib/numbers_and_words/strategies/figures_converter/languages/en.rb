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
            figures.ones ? tens_with_ones : tens
          end

          def hundreds_number_to_words
            simple_number_to_words + maybe_union_after_hundreds([hundreds])
          end

          def simple_number_to_words
            if figures.teens
              [teens]
            elsif figures.tens
              [complex_tens]
            elsif figures.ones
              [ones]
            else
              []
            end
          end

          def capacity_iteration capacity
            words = []
            capacity_words = words_in_capacity(capacity)
            words.push(megs) unless capacity_words.empty?
            words + capacity_words
          end

          [:ones, :teens, :tens, :hundreds, :megs].each do |method_name|
            define_method(method_name) { translate method_name }
          end

          def tens_with_ones
            translate :tens_with_ones, {:separator => maybe_hyphen_separator}
          end

          def translate type, options = {}
            maybe_ordinal type,
              Proc.new { |*args| translations.send type, *args },
              options
          end

          def maybe_hyphen_separator
            @options.remove_hyphen.result
          end

          def maybe_ordinal type, proc_method, options = {}
            @options.ordinal.result type, proc_method, options
          end

          def maybe_union_after_hundreds translations
            @options.hundreds_with_union.modify_or_leave translations
          end
        end
      end
    end
  end
end
