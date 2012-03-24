module TranslationsHelpers::En
  include TranslationsHelpers::Base

  private

  def translation_megs capacity
    t(:mega)[capacity]
  end

  def translation_teens number
    t(:teens)[number]
  end

  def translation_tens number
    t(:tens)[number]
  end

  def translation_ones number
    t(:ones)[number]
  end

  def translation_tens_with_ones numbers
    [translation_tens(numbers[1]), translation_ones(numbers[0])].join '-'
  end

  def translation_union
    t :union
  end

  def translation_hundreds number
    [t(:ones)[number], t(:hundreds)].join ' '
  end

  def zero
    t(:ones_male)[0]
  end
end
