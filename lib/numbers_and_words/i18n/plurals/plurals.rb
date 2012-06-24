Hash[
  NumbersAndWords::I18n::Pluralization.languages.map { |language|
    [language.to_sym, {:i18n => {:plural => {
      :rule => "NumbersAndWords::I18n::Plurals::#{language.titleize}::RULE".constantize
    }}}]
  }
]
