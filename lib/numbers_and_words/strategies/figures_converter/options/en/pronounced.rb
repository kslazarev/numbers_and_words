module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module En
          class Pronounced
            attr_accessor :strategy, :options

            def initialize proxy, *args, &block
              @strategy = proxy.strategy
              @options = proxy.options
            end


            def result
              active? ? 'PRONOUNCED' : 'NOTPRONOUNCED'
            end

            def active?
              @options[:pronounced]
            end

            def process language, figures
              if figures.to_a.count > 4
                language.number_without_capacity_to_words + language.complex_number_to_words
              elsif figures.capacity_count
                handle_thousands language, figures
              elsif figures.hundreds
                handle_hundreds language, figures
              elsif figures.tens or figures.ones
                language.simple_number_to_words
              else
                []
              end
            end

            def handle_thousands language, figures
              units, tens, hundreds, thousands = *figures.to_a.dup
              if hundreds == 0
                language.number_without_capacity_to_words + language.complex_number_to_words
              else
                result = tens_with_oh language, figures
                result.push "#{thousands}#{hundreds}".to_i.to_words
              end
            end

            def handle_hundreds language, figures
              units, tens, hundreds = *figures.to_a.dup
              result = tens_with_oh language, figures
              result.push hundreds.to_words
            end

            def tens_with_oh language, figures
              units, tens = *figures.to_a.dup
              result = []
              if tens == 0
                if units == 0
                  result.push 'hundred'
                else
                  result.push language.ones
                  result.push 'oh'
                end
              else
                if figures.teens
                  result.push language.teens
                elsif figures.tens
                  result.push language.complex_tens
                end
              end
            end
          end
        end
      end
    end
  end
end
