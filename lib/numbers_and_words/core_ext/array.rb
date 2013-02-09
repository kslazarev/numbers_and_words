class Array
  def to_words options = {}
    map { |member| member.to_words options }
  end

  def to_figures
    NumbersAndWords::FiguresArray.new self
  end
end
