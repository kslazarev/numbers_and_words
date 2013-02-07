class Integer

  def to_words options = {}
    to_figures_array.to_words NumbersAndWords::Strategies::Base.factory, options
  end

  private

  def to_figures_array
    to_s.split(//).map(&:to_i).to_figures
  end
end
