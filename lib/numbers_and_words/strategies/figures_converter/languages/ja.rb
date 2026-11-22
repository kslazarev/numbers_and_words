# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        # Spells whole numbers from the rule sets in numbers.ja.yml, with the words of the script asked for
        # (numbers.kanji or numbers.kana); see RuleSets.
        class Ja < Base
          include Myriad

          def words
            check_scale!('Japanese')
            super
          end

          private

          def option_words
            [script.to_s]
          end

          def scales
            @translations.t(script)[:scales]
          end

          def digit_word(digit)
            @translations.ones(digit, script)
          end

          def script
            @options.script.result
          end
        end
      end
    end
  end
end
