# frozen_string_literal: true

def fixture_examples(type, language)
  caller(1..1).first =~ /(.*):(\d+)/
  dir_name = File.dirname(Regexp.last_match(1))
  fixture_file = "#{language}.yml"
  YAML.safe_load_file([dir_name, type.inspect.downcase, 'fixture_examples', fixture_file].join('/'), permitted_classes: [Symbol])
end

# The bundled languages that read decimals; the others raise NumbersAndWords::UnsupportedNumberError for floats.
def decimal_languages
  NumbersAndWords::I18n.languages.select do |locale|
    NumbersAndWords::Strategies::FiguresConverter::Decorators.decimals?(locale.to_s.split('-').map(&:capitalize).join)
  end
end
