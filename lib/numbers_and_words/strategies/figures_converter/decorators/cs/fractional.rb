# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module Cs
          class Fractional < Base
            def run
              @options[:gender] = :female
              "#{super} #{fraction_significance}"
            end

            private

            def fraction_significance
              @strategy.translations.micros full_fraction.fraction_capacity, figures.reverse.join.to_i
            end

            def full_fraction
              (0..zero_length).inject(figures.clone) { |result, _el| result.unshift '0' }.to_figures
            end

            def figures
              @strategy.figures
            end

            def zero_length
              fraction_length - figures.length
            end

            def fraction_length
              @options[:fractional][:length].to_i
            end
          end
        end
      end
    end
  end
end
