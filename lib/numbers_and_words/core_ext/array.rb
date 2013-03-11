class Array
  def to_words options = {}
    map &:to_words
  end

  def to_figures
    NumbersAndWords::FiguresArray.new self
  end
end
