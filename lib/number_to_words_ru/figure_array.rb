class Array
  I18N_NAMESPACE = 'numbers'
  THOUSAND_CAPACITY = 1

  def self.new_numerical_array number
    number.to_s.split(//).collect{|s| s.to_i}.reverse
  end

  def to_words
    validate_numerical_array!
    !strings.empty? ? strings.reverse.join(' ') : zero
  end

  def strings gender = 'male'
    I18n.with_locale(:ru) do
      if capacity_count
        complex_to_words
      elsif hundreds
        simple_hundreds_to_words gender
      elsif tens or ones
        simple_to_words gender
      else
        []
      end
    end
  end

  private

  def complex_to_words
    words = []
    capacity_count.times do |capacity|
      number_in_capacity_by_words = numerical_array_in_capacity(capacity).strings(
        is_a_thousand_capacity?(capacity) ? 'female' : 'male'
      )

      if !number_in_capacity_by_words.empty?
        words.push translation_mega(capacity) if 0 < capacity
        words += number_in_capacity_by_words
      end
    end
    words
  end

  def simple_hundreds_to_words gender
    simple_to_words(gender) + [translation_hundreds(hundreds)]
  end

  def simple_to_words gender
    if teens
      [translation_teens(ones)]
    elsif tens
      ones ? [translation_tens_with_ones(tens_with_ones, gender)] : [translation_tens(tens)]
    elsif ones
      [translation_ones(ones, gender)]
    else
      []
    end
  end

  def capacity_count
    count = (self.length.to_f / 3).ceil
    1 == count ? nil : count
  end

  def numerical_array_in_capacity capacity
    self[capacity * 3, 3]
  end

  def is_a_thousand_capacity? capacity
    THOUSAND_CAPACITY == capacity
  end

  def translation_mega capacity
    I18n.t(
      ".#{I18N_NAMESPACE}.#{I18n.t(".#{I18N_NAMESPACE}.mega")[capacity]}",
      :count => numerical_array_in_capacity(capacity).reverse.join.to_i
    )
  end

  def ones
    self[0] if 0 < self[0]
  end

  def teens
    tens_with_ones if 1 == tens
  end

  def tens
    self[1] if self[1] and 0 < self[1]
  end

  def tens_with_ones
    [ones, tens] if ones and tens
  end

  def hundreds
    0 == self[2].to_i ? nil : self[2]
  end

  def translation_teens number
    I18n.t(".#{I18N_NAMESPACE}.teens")[number]
  end

  def translation_tens number
    I18n.t(".#{I18N_NAMESPACE}.tens")[number]
  end

  def translation_ones number, gender
    I18n.t(".#{I18N_NAMESPACE}.ones_#{gender}")[number]
  end

  def translation_tens_with_ones numbers, gender
    "#{translation_tens(numbers[1])} #{translation_ones(numbers[0], gender)}"
  end

  def translation_hundreds number
    I18n.t(".#{I18N_NAMESPACE}.hundreds")[number]
  end

  def zero
    I18n.t(".#{I18N_NAMESPACE}.ones_male")[0]
  end

  def validate_numerical_array!
    self.each do |element|
      if !element.kind_of? Integer
        raise "Array is not numerical: '#{element}' must be integer"
      end
    end
  end
end