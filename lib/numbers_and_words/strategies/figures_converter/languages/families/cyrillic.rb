# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        module Families
          module Cyrillic
            include Base

            def gender
              @current_capacity ||= 0

              case @current_capacity
              when 1
                :female
              when 0
                options.gender.result
              else
                :male
              end
            end

            %i[ones tens_with_ones].each do |method_name|
              define_method(method_name) do |*args|
                super({ gender: gender }.merge(args.first || {}))
              end
            end

            def megs(*args)
              super({ number: @figures.number_in_capacity(@current_capacity) }.merge(args.first || {}))
            end
          end
        end
      end
    end
  end
end
