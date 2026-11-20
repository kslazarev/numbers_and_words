# frozen_string_literal: true

require 'fileutils'
require 'rake'

desc 'Build the gem into pkg/'
task :build do
  specification = Gem::Specification.load('numbers_and_words.gemspec')
  FileUtils.mkdir_p('pkg')
  sh Gem.ruby, '-S', 'gem', 'build', 'numbers_and_words.gemspec', '--output', "pkg/#{specification.full_name}.gem"
end
