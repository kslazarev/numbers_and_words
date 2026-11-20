# frozen_string_literal: true

module NumbersAndWords
  module I18n
    module Pluralization
      DIRECTORY = File.expand_path('plurals', __dir__)
      # Loaded through I18n.load_path; maps each language to its rule.
      CONFIG_FILE = File.join(DIRECTORY, 'plurals.rb')
      # One file per language defining Plurals::<Language>::RULE.
      RULE_FILES = (Dir[File.join(DIRECTORY, '*.rb')] - [CONFIG_FILE]).sort.each { |file| require file }.freeze

      module_function

      def init
        ::I18n::Backend::Simple.include ::I18n::Backend::Pluralization
      end

      def languages
        I18n.enabled(RULE_FILES.map { |file| I18n.language_of(file) })
      end
    end
  end
end
