# frozen_string_literal: true

require 'yaml'
require 'numbers_and_words/i18n/plural_rule'

module NumbersAndWords
  module I18n
    module Pluralization
      # Loaded through I18n.load_path; maps each language to its rule.
      CONFIG_FILE = File.expand_path('plurals.rb', __dir__)

      module_function

      def init
        ::I18n::Backend::Simple.include ::I18n::Backend::Pluralization
      end

      # The enabled languages with plural rules.
      def languages
        I18n.enabled(rules.keys)
      end

      def rule(language)
        rules.fetch(language)
      end

      # The rule of each bundled language that has numbers.plural in its locale file, read from the file itself,
      # since I18n loads the rules while it loads translations.
      def rules
        @rules ||= I18n.locale_files.each_with_object({}) do |file, rules|
          next unless File.read(file).include?("\n    plural:\n")

          language = I18n.language_of(file)
          rules[language] = PluralRule.new(YAML.load_file(file).dig(language.to_s, 'numbers', 'plural')).to_proc
        end
      end
    end
  end
end
