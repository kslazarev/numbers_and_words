# frozen_string_literal: true

class Integer
  def to_words(options = {})
    NumbersAndWords::Fallback.convert(options, -> { to_s }) do |converted|
      converted = NumbersAndWords::OptionsValidation.validate!(converted)
      NumbersAndWords::Unit.convert(self, NumbersAndWords::Compatibility.defaults(converted, self))
    end
  end
end
