class Integer
  THOUSAND = 1000
  MILLIONS = 1000000
  BILLIONS = 1000000000
  I18N_NAMESPACE = 'numbers'

  def to_words
    numbers = to_figure_array.reverse
    words = []

    I18nInitialization.environment do
      (numbers.length.to_f / 3).ceil.times do |capacity|
        words.push(translation_mega(numbers, capacity)) if 0 < words.length and 0 < capacity
        words += trio(numbers[capacity * 3, 3], translation_kind(1000 ** capacity))
      end
    end

    words.reverse.join(" ")
  end

  private

  def to_figure_array
    to_s.split(//).collect{|s| s.to_i}
  end

  def trio numbers, kind
    strings = pare(numbers[0, 2], kind)
    strings.push(translation_hundreds(numbers[2])) if numbers[2] and 0 < numbers[2]
    strings
  end

  def pare numbers, kind
    strings = []

    if 1 == numbers[1]
      strings.push(translation_teens(numbers[0]))
    elsif numbers[1] and 0 < numbers[1]
      strings.push(numbers[0] == 0 ?
        translation_tens(numbers[1]) : translation_tens_with_ones(numbers[0, 2], kind))
    elsif 0 <= numbers[0]
      strings.push(translation_ones(numbers[0], kind))
    end

    strings
  end

  def translation_kind number
    THOUSAND == number ? 'female' : 'male'
  end

  def translation_mega numbers, capacity
    I18n.t(
      ".#{I18N_NAMESPACE}.#{I18n.t(".#{I18N_NAMESPACE}.mega")[capacity]}",
      :count => numbers[capacity * 3, 3].join.to_i
    )
  end

  def translation_teens number
    I18n.t(".#{I18N_NAMESPACE}.teens")[number]
  end

  def translation_tens number
    I18n.t(".#{I18N_NAMESPACE}.tens")[number]
  end

  def translation_ones number, kind
    I18n.t(".#{I18N_NAMESPACE}.ones_#{kind}")[number]
  end

  def translation_tens_with_ones numbers, kind
    "#{translation_tens(numbers[1])} #{translation_ones(numbers[0], kind)}"
  end

  def translation_hundreds number
    I18n.t(".#{I18N_NAMESPACE}.hundreds")[number]
  end

  def zero
    I18n.t(".#{I18N_NAMESPACE}.ones_male")[0]
  end
end