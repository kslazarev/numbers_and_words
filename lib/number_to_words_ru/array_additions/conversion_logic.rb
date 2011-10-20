module ArrayAdditions
  module ConversionLogic
    I18N_LOCALE = :ru

    def strings gender = :male
      I18n.with_locale(I18N_LOCALE) do
        if capacity_count
          complex_to_words
        elsif hundreds
          simple_hundreds_to_words gender
        elsif tens or ones
          simple_to_words gender
        else
          []
        end
      end
    end

    private

    def complex_to_words
      words = []
      capacity_count.times do |capacity|
        number_in_capacity_by_words = numerical_array_in_capacity(capacity).strings(
          is_a_thousand_capacity?(capacity) ? :female : :male
        )

        if !number_in_capacity_by_words.empty?
          words.push translation_megs(capacity) if 0 < capacity
          words += number_in_capacity_by_words
        end
      end
      words
    end

    def simple_hundreds_to_words gender
      simple_to_words(gender) + [translation_hundreds(hundreds)]
    end

    def simple_to_words gender
      if teens
        [translation_teens(ones)]
      elsif tens
        ones ? [translation_tens_with_ones(tens_with_ones, gender)] : [translation_tens(tens)]
      elsif ones
        [translation_ones(ones, gender)]
      else
        []
      end
    end
  end
end
