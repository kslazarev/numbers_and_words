# frozen_string_literal: true

require 'rubygems'
require 'bundler'

require File.expand_path('lib/numbers_and_words/version', __dir__)

begin
  Bundler.setup :default, :development
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = 'numbers_and_words'
  gem.homepage = 'http://github.com/kslazarev/numbers_and_words'
  gem.license = 'MIT'
  gem.summary = 'Convert numbers to words using I18N.'
  gem.description = 'Convert numbers to words using I18N.'
  gem.email = 'k.s.lazarev@gmail.com'
  gem.version = NumbersAndWords::VERSION
  gem.authors = ['Kirill Lazarev']
  gem.files = Dir.glob('lib/**/*')
end

Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec) { |t| t.ruby_opts = '-w' }

task default: %i[rubocop spec]

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "numbers_and_words #{version}"
  rdoc.rdoc_files.include 'README*'
  rdoc.rdoc_files.include 'LICENSE*'
  rdoc.rdoc_files.include 'lib/**/*.rb'
end
