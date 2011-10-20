module ArrayAdditions
  module Translations
    I18N_NAMESPACE = :numbers

    private

    def translation_megs capacity
      I18n.t(translation_mega(capacity),
        :scope => I18N_NAMESPACE,
        :count => numerical_array_in_capacity(capacity).reverse.join.to_i
      )
    end

    def translation_teens number
      I18n.t(:teens, :scope => I18N_NAMESPACE)[number]
    end

    def translation_tens number
      I18n.t(:tens, :scope => I18N_NAMESPACE)[number]
    end

    def translation_ones number, gender
      I18n.t([:ones, gender].join('_'), :scope => I18N_NAMESPACE)[number]
    end

    def translation_tens_with_ones numbers, gender
      [translation_tens(numbers[1]), translation_ones(numbers[0], gender)].join ' '
    end

    def translation_hundreds number
      I18n.t(:hundreds, :scope => I18N_NAMESPACE)[number]
    end

    def translation_mega capacity
      I18n.t(:mega, :scope => I18N_NAMESPACE)[capacity]
    end

    def zero
      I18n.t(:ones_male, :scope => I18N_NAMESPACE)[0]
    end
  end
end
