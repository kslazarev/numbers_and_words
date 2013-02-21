class Float

  def to_words options = {}
    options[:exponential] = true if exponential?
    language_support? { strategy.union_elements parts_to_words(options), options }
  end

  private

  def strategy
    NumbersAndWords::Strategies::Base.factory
  end

  def language_support?
    strategy.support_fractional_options? ? yield : raise(StandardError, 'Unsupported Language')
  end


  def parts_to_words options = {}
    number_array = [[integral_part.to_i, integral_options]]
    number_array << [fractional_part.to_i, fractional_options] unless fractional_part_is_nil?
    number_array.to_words options
  end

  def parts
    to_s.split '.'
  end

  def exponential?
    to_s =~ /[eE]{1}\+/
  end

  def integral_part
    parts.first
  end

  def integral_part_is_nil?
    0 == integral_part.to_i
  end

  def integral_options
    {:print_format => :integral}
  end

  def fractional_part
    parts.last
  end

  def fractional_part_is_nil?
    0 == fractional_part.to_i
  end

  def fractional_options
    {:print_format => :fractional, :fraction_length => fractional_part.length}
  end


end
