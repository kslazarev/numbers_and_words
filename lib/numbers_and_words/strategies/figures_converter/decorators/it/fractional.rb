# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Decorators
        module It
          class Fractional < Base
            def run
              words = normalize_singular_fraction_words(super)
              "#{words} #{fraction_significance}"
            end

            private

            def fraction_significance
              @strategy.translations.micros full_fraction.fraction_capacity, figures.join.to_i
            end

            def singular_fraction?
              figures.join.to_i == 1
            end

            def normalize_singular_fraction_words(words)
              return words unless singular_fraction?

              tokens = words.split
              one = @strategy.translations.ones(1)
              singular_one = @strategy.translations.t(:fractional_one)
              tokens[-1] = singular_one if tokens.last == one
              tokens.join(' ')
            end

            def full_fraction
              (0..zero_length).inject(figures.clone) { |result, _el| result.unshift 0 }.to_figures
            end

            def figures
              @strategy.figures.reverse
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
