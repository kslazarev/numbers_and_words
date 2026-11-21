# frozen_string_literal: true

class Array
  def to_words(options = {})
    NumbersAndWords::OptionsValidation.validate!(options)
    # Options are validated once for the whole array, not again for every element.
    map { |element| NumbersAndWords::Wrappers.for(element).to_words options }
  end

  def to_figures
    NumbersAndWords::FiguresArray.new self
  end
end
