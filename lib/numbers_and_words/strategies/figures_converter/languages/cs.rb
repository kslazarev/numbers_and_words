# frozen_string_literal: true

module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class Cs < Base
          # methods in translations/cs.rb which can work with :gender or :ordinal
          %i[ones teens tens tens_with_ones hundreds].each do |method_name|
            define_method(method_name) do
              super(internal_options)
            end
          end

          def zero
            super(internal_options) unless maybe_remove_zero
          end

          # Ordinals of 1,000 to 9,999 start with one word for the thousands ("tisící", "dvoutisící").
          ORDINAL_LIMIT = 10_000

          def words
            raise RangeError, 'Czech ordinals support numbers below 10,000' if maybe_ordinal && @figures.reverse.join.to_i >= ORDINAL_LIMIT

            super
          end

          # "tisíc" rather than "jeden tisíc" for a thousands group of one, and "tisící" in ordinals.
          def capacity_iteration
            return super unless @current_capacity == FiguresArray::THOUSAND_CAPACITY

            thousands = @figures.number_in_capacity(@current_capacity)
            return [@translations.t('ordinal.thousands')[thousands]] if maybe_ordinal && thousands.positive?
            return [megs] if thousands == 1

            super
          end

          def megs(*args)
            super({ number: @figures.number_in_capacity(@current_capacity) }.merge(args.first || {}))
          end

          def gender
            # @current_capacity = order of block of 3 digits, backwards (0 = hundreds tens ones)
            @current_capacity ||= 0

            if @current_capacity.zero?
              options.gender.result
            elsif @current_capacity > 2 && @current_capacity.odd?
              :female # miliardy, biliardy, triliardy...
            else
              :male
            end
          end

          private

          def internal_options
            { gender:, prefix: maybe_ordinal }
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
