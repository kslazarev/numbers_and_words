module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Options
        module Hu
          class Ordinal
            ZERO_TYPE = :zero
            HUNDRED_TYPE = :hundreds
            MEGS_TYPE = :megs

            attr_accessor :strategy, :options

            def initialize proxy, *args, &block
              @strategy = proxy.strategy
              @options = proxy.options
            end

            def result type, proc_method, proc_options = {}
              @type, @proc_method, @proc_options = type, proc_method, proc_options
              MEGS_TYPE != type ? check_simple_numbers : check_megs_numbers
            end

            private

            def active?
              @options[:ordinal]
            end

            def check_simple_numbers
              @proc_options[:prefix] = :ordinal if simple_numbers_condition && active?
              if ZERO_TYPE != @type
                @proc_method.call figures.send(@type), @proc_options
              else
                @proc_method.call @proc_options
              end
            end

            def check_megs_numbers
              @proc_options[:prefix] = :ordinal if megs_numbers_condition && active?
              @proc_method.call current_capacity, nil, @proc_options
            end

            def simple_numbers_condition
              current_capacity.nil? &&
                (HUNDRED_TYPE != @type || (HUNDRED_TYPE == @type && simple_number_to_words.empty?))
            end

            def megs_numbers_condition
              current_capacity == language_figures.ordinal_capacity
            end

            def simple_number_to_words
              strategy.language.simple_number_to_words
            end

            def current_capacity
              strategy.language.current_capacity
            end

            def language_figures
              strategy.language.parent_figures
            end

            def figures
              strategy.language.figures
            end
          end
        end
      end
    end
  end
end