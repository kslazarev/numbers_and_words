class FloatAsIntegerPair < Array
  def to_words options = {}
    map! do |element|
      element, options = element.first, options.merge(element.last) if element.is_a?(Array)
      element.to_words options
    end

    language_support? {
      strategies.array_joiner.run t, options[:joiner]
    }
  end

  private

  def strategies
    NumbersAndWords::Strategies::Base
  end

  def language_support?
    strategy.support_fractional_options? ? yield : raise(StandardError, 'Unsupported Language')
  end

  def t
    #number_array << [fractional_part.to_i, fractional_options] unless fractional_part_is_nil?
  end

  def integral_part
    first
  end

  def fractional_part
    last
  end

  def integral_options
    {:print_format => :integral}
  end

  def fractional_options
    {:print_format => :fractional, :fraction_length => fractional_part.length}
  end

  def integral_part_is_nil?
    0 == integral_part.to_i
  end

  def fractional_part_is_nil?
    0 == fractional_part.to_i
  end
end