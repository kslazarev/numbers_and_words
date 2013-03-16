module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class En < Base
          include Families::Latin

          [:ones, :teens, :tens, :megs].each do |method_name|
            define_method(method_name) {
              super({:prefix => maybe_ordinal(method_name)})
            }
          end

          def hundreds
            maybe_union_after_hundreds super({:prefix => maybe_ordinal(:hundreds)})
          end

          def zero
            super({:prefix => maybe_ordinal(:zero)}) unless maybe_remove_zero
          end

          def tens_with_ones
            super({
              :separator => maybe_hyphen_separator,
              :prefix => maybe_ordinal(:tens_with_ones)
            })
          end

          def maybe_hyphen_separator
            @options.remove_hyphen.result
          end

          def maybe_ordinal type
            @options.ordinal.result type
          end

          def maybe_union_after_hundreds translations
            @options.hundreds_with_union.modify_or_leave translations
          end

          def maybe_remove_zero
            @options.remove_zero.result
          end
        end
      end
    end
  end
end
