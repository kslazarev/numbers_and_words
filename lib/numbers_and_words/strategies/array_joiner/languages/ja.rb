# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module ArrayJoiner
      module Languages
        # Japanese joins the integral and fractional parts with 点 (てん) and no spaces.
        class Ja < Base
          # The separator stays when remove_zero omits the integral part, and the kana sound changes apply
          # before it: 1.5 is いってんご.
          def elements_logic
            @elements.inject { |text, element| join_words(join_words(text, micro_separator), element) }
          end

          def micro_separator
            options[:micro_separator] || @translations.micro_separator(script)
          end

          private

          def join_words(left, right)
            @translations.join(left, right, script)
          end

          def script
            options[:script]&.to_sym || :kanji
          end
        end
      end
    end
  end
end
