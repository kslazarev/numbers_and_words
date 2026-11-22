# frozen_string_literal: true

class Array
  def to_words(options = {})
    NumbersAndWords::Fallback.convert(options, -> { map(&:to_s) }) do |converted|
      converted = NumbersAndWords::Compatibility.defaults(NumbersAndWords::OptionsValidation.validate!(converted), self)
      # Options are validated once for the whole array, not again for every element.
      map { |element| NumbersAndWords::Unit.convert(element, converted) }
    end
  end

  def to_figures
    NumbersAndWords::FiguresArray.new self
  end
end
