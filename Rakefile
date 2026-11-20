# frozen_string_literal: true

require 'rake'
require 'rubygems'
require_relative 'lib/numbers_and_words/version'
require_relative 'tasks/build'

if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
  require_relative 'tasks/release'
  NumbersAndWordsRelease.workflow.install_tasks
end

require 'rspec/core'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec) { |t| t.ruby_opts = '-w' }

task default: %i[rubocop spec]

desc 'Benchmark conversion throughput and allocations'
task :benchmark do
  ruby 'benchmark/convert.rb'
end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "numbers_and_words #{NumbersAndWords::VERSION}"
  rdoc.rdoc_files.include 'README*'
  rdoc.rdoc_files.include 'LICENSE*'
  rdoc.rdoc_files.include 'lib/**/*.rb'
end
