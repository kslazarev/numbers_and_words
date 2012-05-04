def yml_examples
  caller.first =~ /(.*):(\d+)/
  dir_name = File.dirname($1)
  fixture_file = "#{File.basename($1).split('_spec').first}.yml"
  YAML::load File.open([dir_name, 'fixture_examples', fixture_file].join('/'))
end
