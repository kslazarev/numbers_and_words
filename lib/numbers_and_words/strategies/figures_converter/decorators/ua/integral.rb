module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Ua
          class Integral < Base

            def run
              @options[:gender] = :female
              "#{super} #{integral_significance}"
            end

            private

            def integral_significance
              @strategy.translations.integral figures.reverse.join.to_i
            end

            def figures
              @strategy.language.figures
            end
          end
        end
      end
    end
  end
end