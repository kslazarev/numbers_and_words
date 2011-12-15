require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake/gempackagetask'
require 'rubygems/specification'

GEM = "number_to_words_ru"
GEM_VERSION = "0.2.3"
AUTHOR = "Kirill Lazarev"
EMAIL = "k.s.lazarev@gmail.com"
HOMEPAGE = "http://github.com/kslazarev/number_to_words_ru"
SUMMARY = "Simple convert number to russian words using I18N."
LICENSE = "MIT"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  #s.extra_rdoc_files = ["README.textile", "LICENSE", "CHANGELOG", "TODO"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.license = LICENSE
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = Dir.glob("{lib,spec}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

#task :default => :spec

#require 'spec/rake/spectask'
#require 'date'

#desc "Run specs"
#Spec::Rake::SpecTask.new do |t|
#  t.spec_files = FileList['spec/**/*_spec.rb']
#  t.spec_opts = %w(-fs --color)
#end

desc "install the gem locally"
task :install => [:package] do
  sh %{gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
