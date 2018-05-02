# frozen_string_literal: true

def fixture_examples(type, language)
  caller(1..1).first =~ /(.*):(\d+)/
  dir_name = File.dirname(Regexp.last_match(1))
  fixture_file = "#{language}.yml"
  YAML.safe_load(File.open(
                   [dir_name, type.inspect.downcase, 'fixture_examples', fixture_file].join('/')
  ), [Symbol])
end
