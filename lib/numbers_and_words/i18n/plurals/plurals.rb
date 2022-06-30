# frozen_string_literal: true

NumbersAndWords::I18n::Pluralization.languages.to_h do |language|
  [language.to_sym, {
    i18n: {
      plural: {
        rule: Object.const_get("NumbersAndWords::I18n::Plurals::#{language.split('-').collect(&:capitalize).join}::RULE")
      }
    }
  }]
end
