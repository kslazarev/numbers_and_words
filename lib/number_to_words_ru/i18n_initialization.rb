module I18nInitialization
  extend self

  def environment
    working_locale = I18n.locale
    I18n.locale = :ru
    I18n.load_path += locale_files
    yield
    I18n.load_path.pop locale_files.count
    I18n.locale = working_locale
  end

  def locale_files
    Dir[File.join(File.dirname(__FILE__), "..", "locales", "**/*")]
  end
end