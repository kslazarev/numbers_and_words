# frozen_string_literal: true

class Array
  def to_words(options = {})
    NumbersAndWords::Fallback.convert(options, -> { map(&:to_s) }) do |converted|
      NumbersAndWords::OptionsValidation.validate!(converted)
      # Options are validated once for the whole array, not again for every element.
      map { |element| NumbersAndWords::Wrappers.for(element).to_words options }
    end
  end

  def to_figures
    NumbersAndWords::FiguresArray.new self
  end
end
