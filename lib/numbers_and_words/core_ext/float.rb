class Float
  def to_words options = {}
    NumbersAndWords::Wrappers::Float.new(self).to_words options
  end
end
