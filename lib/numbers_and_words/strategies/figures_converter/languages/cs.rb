module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Cs < Base
          include Families::Latin

          # methods in translations/cs.rb which can work with :gender or :ordinal
          %i[ones teens tens tens_with_ones hundreds].each do |method_name|
            define_method(method_name) do
              super(internal_options)
            end
          end

          %i[megs thousands].each do |method_name|
            define_method(method_name) do
              super(internal_options)
            end
          end

          def zero
            super(internal_options) unless maybe_remove_zero
          end

          def megs(*args)
            super({ number: @figures.number_in_capacity(@current_capacity) }.merge(args.first || {}))
          end

          def gender
            @current_capacity ||= 0
            # @current_capacity = order of block of 3 digits, backwards

            case @current_capacity
            when 0 # ones
              options.gender.result
            when 3 # miliardy
              :female
            when 5 # biliardy
              :female
            when 7 # triliardy
              :female
            when 9 # kvadriliardy
              :female
            else
              :male
            end
          end

          private

          def internal_options
            { gender: gender, prefix: maybe_ordinal }
          end

          def maybe_remove_zero
            @options.remove_zero.result
          end

          def maybe_ordinal
            @options.ordinal.result
          end
        end
      end
    end
  end
end
