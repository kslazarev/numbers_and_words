# frozen_string_literal: true

def fixture_examples(type, language)
  caller(1..1).first =~ /(.*):(\d+)/
  dir_name = File.dirname(Regexp.last_match(1))
  fixture_file = "#{language}.yml"
  file = File.open([dir_name, type.inspect.downcase, 'fixture_examples', fixture_file].join('/'))
  if Gem::Version.new(Psych::VERSION) >= Gem::Version.new('3.1.0.pre1')
    YAML.safe_load(file, permitted_classes: [Symbol])
  else
    YAML.safe_load(file, [Symbol])
  end
end
