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
              @language = language
              @figures = figures
              units, tens, hundreds, thousands = *@figures.to_a.dup

              if figures.to_a.count > 4
                @language.number_without_capacity_to_words + @language.complex_number_to_words
              elsif @figures.capacity_count
                handle_thousands thousands, hundreds, tens, units
              elsif @figures.hundreds
                handle_hundreds hundreds, tens, units
              elsif @figures.tens or @figures.ones
                @language.simple_number_to_words
              else
                []
              end
            end

            def handle_thousands thousands, hundreds, tens, units
              if hundreds == 0
                @language.number_without_capacity_to_words + @language.complex_number_to_words
              else
                result = []
                if tens == 0 && units == 0
                  result.push 'hundred'
                else
                  result += tens_with_oh tens, units
                end
                result.push "#{thousands}#{hundreds}".to_i.to_words
                result
              end
            end

            def handle_hundreds hundreds, tens, units
              result = []
              if tens == 0
                if units == 0
                  result.push @language.hundreds_number_to_words
                else
                  result.push @language.ones
                  result.push 'oh'
                  result.push hundreds.to_words
                end
              else
                if @figures.teens
                  result.push @language.teens
                elsif @figures.tens
                  result.push @language.complex_tens
                end
                result.push hundreds.to_words
              end
              result
            end

            def tens_with_oh tens, units
              result = []
              if tens == 0
                if units != 0
                  result.push @language.ones
                  result.push 'oh'
                end
              else
                if @figures.teens
                  result.push @language.teens
                elsif @figures.tens
                  result.push @language.complex_tens
                end
              end
            end
          end
        end
      end
    end
  end
end
