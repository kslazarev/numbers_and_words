# frozen_string_literal: true

# The features of every bundled language, as docs/features.md shows them. spec/numbers_and_words/feature_matrix_spec.rb
# checks the page, and `bundle exec ruby script/features.rb` writes it.
module FeatureMatrix
  PAGE = File.expand_path('../../docs/features.md', __dir__)

  # Options a language declares that the columns already show, or that only some readings of a language have.
  SHOWN = %i[ordinal remove_zero gender case animate fraction].freeze

  HEADER = <<~MARKDOWN
    # Features

    This page lists what each bundled language supports. The `bundle exec ruby script/features.rb` command generates this page from the locale files and classes, and a spec fails when it is out of date. The [README](../README.md#options--опции--options) documents the options every language shares, and each language's page documents its own.

    * **Decimals**: The column says whether floats such as `21.77.to_words` read without a unit. The value *fraction* means `fraction: true` also reads them as a fraction.
    * **Gender** and **Case**: The columns give the values of `gender:` and `case:`. The value *animate* means the language also accepts `animate:`.
    * **Ordinals**: The column gives the numbers `ordinal: true` spells. The value *all* means every number up to the largest number; otherwise the column gives a range.
    * **Largest number**: Numbers from this power of ten raise `RangeError`.
    * **Other options**: The column lists the language's own options.

  MARKDOWN

  module_function

  def page
    rows = NumbersAndWords::I18n.languages.sort.map { |language| row(language) }
    [HEADER, '| Language | Decimals | Gender | Case | Ordinals | Largest number | Other options |', '| --- | --- | --- | --- | --- | --- | --- |', *rows].join("\n") << "\n"
  end

  def row(language)
    "| #{cells(language).map { |cell| cell.to_s.empty? ? '—' : cell }.join(' | ')} |"
  end

  def cells(language)
    options = NumbersAndWords::OptionsValidation.language_options(language)
    [
      "[`#{language}`](languages/#{language}.md)", decimals(language, options), values(options[:gender]), cases(options),
      ordinals(NumbersAndWords::OptionsValidation.declared_options(language)[:ordinal]), largest(language),
      (options.keys - SHOWN).sort.map { |name| "`#{name}`" }.join(', ')
    ]
  end

  def cases(options)
    [values(options[:case]), ('animate' if options.key?(:animate))].compact.join(', ')
  end

  def decimals(language, options)
    return 'no' unless NumbersAndWords::Strategies::FiguresConverter::Decorators.decimals?(language)

    options.key?(:fraction) ? 'yes, fraction' : 'yes'
  end

  def values(check)
    check.is_a?(Array) ? check.join(', ') : nil
  end

  def ordinals(declared)
    return 'no' unless declared
    return 'all' unless declared.is_a?(Hash) && (declared[:minimum] || declared[:maximum])
    return "from #{declared[:minimum]}" unless declared[:maximum]

    "#{declared[:minimum]} to #{declared[:maximum]}"
  end

  # The first power of ten that raises RangeError, up to 10**120.
  def largest(language)
    power = (1..120).find do |exponent|
      I18n.with_locale(language) { (10**exponent).to_words }
      false
    rescue RangeError
      true
    end
    power ? "10<sup>#{power}</sup>" : 'unlimited'
  end
end
