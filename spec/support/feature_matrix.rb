# frozen_string_literal: true

# The features of every bundled language, as docs/features.md shows them. spec/numbers_and_words/feature_matrix_spec.rb
# checks the page, and `bundle exec ruby script/features.rb` writes it.
module FeatureMatrix
  PAGE = File.expand_path('../../docs/features.md', __dir__)

  # Options a language declares that the columns already show, or that only some readings of a language have.
  SHOWN = %i[ordinal remove_zero gender case animate fraction].freeze

  HEADER = <<~MARKDOWN
    # Features

    What each bundled language supports, generated from its locale file and classes by `bundle exec ruby script/features.rb`; a spec fails when this page is out of date. The [README](../README.md#options--опции--options) documents the options every language shares, and each language's page its own.

    * **Decimals**: floats such as `21.77.to_words` read without a unit; *fraction* also reads them as a fraction with `fraction: true`.
    * **Gender** and **Case**: the values of `gender:` and `case:`; *animate* adds `animate:`.
    * **Ordinals**: the numbers `ordinal: true` spells, all of them up to the largest number unless a range is given.
    * **Largest number**: numbers from this power of ten raise `RangeError`.
    * **Other options**: options of the language's own.

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
    return 'all' unless declared.is_a?(Hash) && declared[:maximum]

    "#{declared[:minimum]} to #{declared[:maximum]}"
  end

  def largest(language)
    mega = I18n.t('numbers.mega', locale: language, default: nil)
    mega ? "10<sup>#{mega.size * 3}</sup>" : 'unlimited'
  end
end
