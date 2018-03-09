# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        module Families
          module Helpers
            def zero(*args)
              options = args.first || {}
              translate :zero, options
            end

            %i[ones teens tens tens_with_ones hundreds].each do |method_name|
              define_method(method_name) do |*args|
                options = args.first || {}
                translate method_name, @figures.send(method_name), options
              end
            end

            def megs(*args)
              options = args.first || {}
              translate :megs, @current_capacity, options
            end

            def translate(method_name, *args)
              translations.send method_name, *args
            end
          end
        end
      end
    end
  end
end
