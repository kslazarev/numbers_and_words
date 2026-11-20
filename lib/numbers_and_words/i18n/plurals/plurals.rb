# frozen_string_literal: true

NumbersAndWords::I18n::Pluralization.languages.to_h do |language|
  [language, {
    i18n: {
      plural: {
        rule: Object.const_get("NumbersAndWords::I18n::Plurals::#{language.to_s.split('-').collect(&:capitalize).join}::RULE")
      }
    }
  }]
end
