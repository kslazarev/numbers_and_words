class Integer
  def to_words
    to_figures_array.to_words Strategies::Base.factory
  end

  private

  def to_figures_array
    to_s.split(//).map(&:to_i).to_figures
  end
end
