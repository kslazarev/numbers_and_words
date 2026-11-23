# frozen_string_literal: true

NumbersAndWords::I18n::Pluralization.languages.to_h do |language|
  [language, { i18n: { plural: { rule: NumbersAndWords::I18n::Pluralization.rule(language) } } }]
end
