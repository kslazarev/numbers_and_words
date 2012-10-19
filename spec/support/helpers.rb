def fixture_examples type, language
  caller.first =~ /(.*):(\d+)/
  dir_name = File.dirname($1)
  fixture_file = "#{language}.yml"
  YAML::load File.open(
    [dir_name, type.inspect.underscore, 'fixture_examples', fixture_file].join('/')
  )
end
