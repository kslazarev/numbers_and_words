# frozen_string_literal: true

module NumbersAndWords
  module I18n
    # A locale whose numbers name another with extends: (British English extends English) takes that locale's
    # numbers with its own on top when I18n's Simple backend loads translations; a key set to ~ drops the other's.
    module Extends
      def load_translations(...)
        super.tap { Extends.apply(translations) }
      end

      # Merges again on every load: the locale's own keys, including those set to ~, always win.
      def self.apply(translations)
        translations.each_value do |data|
          parent = data.is_a?(Hash) && data[:numbers].is_a?(Hash) && data[:numbers][:extends]
          next unless parent

          data[:numbers] = merge(translations.dig(parent.to_sym, :numbers) || {}, data[:numbers])
        end
      end

      def self.merge(base, own)
        base.merge(own) { |_key, from, to| from.is_a?(Hash) && to.is_a?(Hash) ? merge(from, to) : to }
      end

      # The locale a bundled file extends, or nil.
      def self.parent(file)
        File.foreach(file).lazy.map { |line| line[/\A    extends: (\S+)/, 1] }.find(&:itself)&.to_sym
      end
    end
  end
end

I18n::Backend::Simple.prepend(NumbersAndWords::I18n::Extends)
