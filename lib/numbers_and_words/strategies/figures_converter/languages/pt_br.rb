module NumbersAndWords
  module Strategies
    module FiguresConverter
      module Languages
        class PtBr < Base
          include Families::Latin

          [:teens, :tens, :tens_with_ones].each do |method_name|
            define_method(method_name) {
              super(internal_options)
            }
          end

          def zero
            super unless maybe_remove_zero
          end

          def words
            super.strip
          end

          def complex_number_to_words
            super.reject { |x| x.nil? }
          end

          def capacity_iteration
            words = []
            capacity_words = words_in_capacity(current_capacity)
            words.push(megs) unless capacity_words.empty? || (capacity_words.empty? && figures[0] == 1)
            words + capacity_words
          end

          def ones
            super internal_options.merge({:is_one_thousand => is_one_thousand?})
          end

          def hundreds
            super(internal_options.merge({:is_hundred => is_hundred?, :is_one_hundred => is_one_hundred?, :gender => gender}))
          end

          def megs
            super(internal_options.merge({
              :is_one => words_in_capacity(current_capacity) == [translations.ones(1, internal_options)],
              :is_opaque => is_opaque?,
              :is_without_connector => is_without_connector?,
              :is_with_comma => is_with_comma?
            }))
          end

          private

          def internal_options
            {:gender => gender, :prefix => maybe_ordinal}
          end

          def maybe_ordinal
            @options.ordinal.result
          end

          def gender
            return (options.gender.result || :male) if maybe_ordinal

            @current_capacity ||= 0
            if @current_capacity > 0 && figures[0] == 1
              :male
            else
              options.gender.result
            end
          end

          def is_hundred?
            figures[0] == 0 && figures[1] == 0 && simple_number_to_words.empty?
          end

          def is_one_hundred?
            is_hundred? && figures[2] == 1
          end

          def is_opaque?
            figures.is_opaque? current_capacity
          end

          def is_one_thousand?
            @current_capacity == 1 && figures[0] == 1 && figures.hundreds.nil? && figures.tens.nil?
          end

          def is_without_connector?
            return false if is_with_comma?
            # without connector when there is hundreds and tens_with_ones
            return true if figures.hundreds and figures.tens_with_ones
            # without connector when there is hundreds and tens
            return true if figures.hundreds and figures.tens
            # without connector when there is hundreds and ones
            return true if figures.hundreds and figures.ones
            false
          end

          def is_with_comma?
            return false unless @current_capacity > 1
            # if any lower capacity is single word, in portuguese only tens are single words
            number_under_capacity = figures.number_under_capacity(@current_capacity)
            return false if number_under_capacity < 20

            figures_under_capacity = figures.figures_array_under_capacity(@current_capacity)
            return false if figures_under_capacity.count(0) == (figures_under_capacity.size - 1)

            # else use comma
            true
          end

          def maybe_remove_zero
            @options.remove_zero.result
          end
        end
      end
    end
  end
end
