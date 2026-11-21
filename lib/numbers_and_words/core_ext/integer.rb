# frozen_string_literal: true

class Integer
  def to_words(options = {})
    NumbersAndWords::Fallback.convert(options, -> { to_s }) do |converted|
      NumbersAndWords::OptionsValidation.validate!(converted)
      NumbersAndWords::Wrappers::Integer.new(self).to_words converted
    end
  end
end
