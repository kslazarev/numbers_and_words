module NumbersAndWords::TranslationsHelpers::Ru
  include NumbersAndWords::TranslationsHelpers::Base

  private

  def translation_megs capacity, number
    t translation_mega(capacity), :count => number
  end

  def translation_teens number
    t(:teens)[number]
  end

  def translation_tens number
    t(:tens)[number]
  end

  def translation_ones number, gender
    t([:ones, gender].join('_'))[number]
  end

  def translation_tens_with_ones numbers, gender
    [translation_tens(numbers[1]), translation_ones(numbers[0], gender)].join ' '
  end

  def translation_hundreds number
    t(:hundreds)[number]
  end

  def translation_mega capacity
    t(:mega)[capacity]
  end

  def zero
    t(:ones_male)[0]
  end
end
