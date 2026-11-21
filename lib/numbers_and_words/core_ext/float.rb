# frozen_string_literal: true

class Float
  def to_words(options = {})
    NumbersAndWords::Fallback.convert(options, -> { to_s }) do |converted|
      NumbersAndWords::OptionsValidation.validate!(converted)
      NumbersAndWords::Unit.convert(self, converted)
    end
  end
end
