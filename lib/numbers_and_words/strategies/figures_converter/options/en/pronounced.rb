# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module En
          class Pronounced
            attr_accessor :strategy, :options

            def initialize(proxy, *_args)
              @strategy = proxy.strategy
              @options = proxy.options
            end

            def active?
              @options[:pronounced]
            end

            def process(language, figures)
              if figures.capacity_count
                handle_thousands language, figures
              elsif figures.hundreds
                handle_hundreds language, figures
              elsif figures.tens || figures.ones
                language.simple_number_to_words
              else
                []
              end
            end

            def handle_thousands(language, figures)
              _units, _tens, hundreds, thousands = *figures.to_a.dup
              if hundreds.zero?
                language.number_without_capacity_to_words + language.complex_number_to_words
              else
                result = tens_with_oh language, figures
                result.push "#{thousands}#{hundreds}".to_i.to_words
              end
            end

            def handle_hundreds(language, figures)
              _units, _tens, hundreds = *figures.to_a.dup
              result = tens_with_oh language, figures
              result.push hundreds.to_words
            end

            def tens_with_oh(language, figures)
              units, tens = *figures.to_a.dup
              return (units.zero? ? ['hundred'] : [language.ones, 'oh']) if tens.zero?
              return [language.teens] if figures.teens

              [language.complex_tens]
            end
          end
        end
      end
    end
  end
end
