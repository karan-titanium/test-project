class Settings < Settingslogic
  source "#{Rails.root}/config/system_settings.yml"
  namespace Rails.env
  suppress_errors Rails.env.production?
  load!
end