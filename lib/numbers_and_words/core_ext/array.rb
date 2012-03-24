class Array
  def to_words
    map &:to_words
  end

  def to_figures
    NumbersAndWords::FiguresArray.new self
  end
end
