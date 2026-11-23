# frozen_string_literal: true

require 'concurrent/map'

module NumbersAndWords
  module I18n
    # Keeps the caches of NumbersAndWords::I18n.cached on I18n's Simple backend, and drops them with the compiled rule
    # sets and the supported options when the backend reloads or stores translations, which may change
    # numbers.rules, numbers.supported_options or the words in place.
    module Invalidation
      def store_translations(...)
        super.tap { clear_numbers_and_words }
      end

      def reload!(...)
        super.tap { clear_numbers_and_words }
      end

      # A cache of NumbersAndWords::I18n.cached, by name.
      def numbers_and_words_cache(name)
        caches = (@numbers_and_words_caches ||= Concurrent::Map.new)
        caches[name] || caches.compute_if_absent(name) { Concurrent::Map.new }
      end

      def clear_numbers_and_words
        @numbers_and_words_caches = nil
        Invalidation.clear
      end

      def self.clear
        Rules.clear
        OptionsValidation.clear
      end
    end
  end
end

I18n::Backend::Simple.prepend(NumbersAndWords::I18n::Invalidation)
