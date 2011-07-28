module I18nInitialization
  extend self

  def environment
    I18n.locale = :ru
    I18n.load_path << locale_files
    yield
    #I18n.load_path.pop 2
    #I18n.locale = I18n.default_locale
  end

  def locale_files
    Dir[File.join(File.dirname(__FILE__), "..", "locales", "**/*")]
  end
end