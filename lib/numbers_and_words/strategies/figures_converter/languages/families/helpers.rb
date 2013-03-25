module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        module Families
          module Helpers
            [:zero].each do |method_name|
              define_method(method_name) { |*args|
                options = args.first || {}
                translate method_name, options
              }
            end

            [:ones, :teens, :tens, :tens_with_ones, :hundreds].each do |method_name|
              define_method(method_name) { |*args|
                options = args.first || {}
                translate method_name, @figures.send(method_name), options
              }
            end

            [:megs].each do |method_name|
              define_method(method_name) { |*args|
                options = args.first || {}
                translate method_name, @current_capacity, options
              }
            end

            def translate method_name, *args
              translations.send method_name, *args
            end
          end
        end
      end
    end
  end
end
