# frozen_string_literal: true

require 'ruby-gem-release/workflow/ruby_gem'
require 'ruby-gem-release/changelog'
require_relative 'build'

module NumbersAndWordsRelease
  def self.workflow(**adapters)
    RubyGemRelease::Workflow::RubyGem.new(
      version: RubyGemRelease::Version::RubyConstant.new(path: 'lib/numbers_and_words/version.rb', constant: 'VERSION'),
      changelog: RubyGemRelease::Changelog::Intridea.new(placeholder: '  * Your contribution here.', sections: %w[Features Bugs]),
      **adapters
    )
  end
end
