# frozen_string_literal: true

class Integer
  def to_words(options = {})
    NumbersAndWords::Wrappers::Integer.new(self).to_words options
  end
end
