# frozen_string_literal: true

module NumbersAndWords
  module I18n
    module Initialization
      module_function

      def init
        I18n.locale_files.each { |locale_file| ::I18n.load_path << locale_file }
        NumbersAndWords::I18n::Pluralization.init
      end
    end
  end
end
