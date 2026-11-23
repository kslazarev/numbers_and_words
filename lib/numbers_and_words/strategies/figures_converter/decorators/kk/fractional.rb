# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Kk
          # Kazakh reads the fractional part as the fraction word in the ablative and the count of it: 0.05 is
          # "нөл бүтін жүзден бес", five of a hundred, after the whole part and бүтін.
          class Fractional < Base
            def run
              fractions = @strategy.translations.t(:fractions)
              raise RangeError, "Decimals in :kk only support up to #{fractions.size} fractional digits." if fraction_length > fractions.size

              "#{fractions[fraction_length - 1]} #{super}"
            end
          end
        end
      end
    end
  end
end
