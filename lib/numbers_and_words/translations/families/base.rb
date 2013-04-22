module NumbersAndWords
  module Translations
    module Families
      module Base

        def teens numbers, options = {}
          t("#{options[:prefix]}.teens")[numbers[0]]
        end

        def tens number, options = {}
          t("#{options[:prefix]}.tens")[number]
        end

        def tens_with_ones numbers, options = {}
          [tens(numbers[1]), ones(numbers[0], options)].join options[:separator]
        end

        def megs capacity, options = {}
          number, mega_name = options[:number], "#{options[:prefix]}.mega"
          number ? t(mega(capacity), :count => number) : t(mega_name)[capacity]
        end

        def mega capacity
          t(:mega)[capacity]
        end

        def union
          t :union
        end

        def union_separator
          t :union_separator
        end
      end
    end
  end
end
