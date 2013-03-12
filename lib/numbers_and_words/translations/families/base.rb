module NumbersAndWords
  module Translations
    module Families
      module Base

        #private

        def teens numbers, options = {}
          t([options[:prefix], :teens].join('.'))[numbers[0]]
        end

        def tens number, options = {}
          t([options[:prefix], :tens].join('.'))[number]
        end

        def tens_with_ones numbers, options = {}
          [tens(numbers[1]), ones(numbers[0], options)].join options[:separator]
        end

        def megs capacity, number = nil, options = {}
          mega_name = [options[:prefix], :mega].join('.')
          number ? t(mega(capacity), :count => number) : t(mega_name)[capacity]
        end

        def mega capacity
          t(:mega)[capacity]
        end

        def fraction_separator options = {}
          t(:fraction_separator)
        end
      end
    end
  end
end
