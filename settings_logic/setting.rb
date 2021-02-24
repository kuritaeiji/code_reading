require_relative('./settings_logic.rb')
# require('settingslogic')

class Settings < SettingsLogic
  def self.env
    'production'
  end

  source(File.join(__dir__, 'settings.yml'))
  namespace(self.env)
end

puts(Settings.cool.saweet)
puts(Settings.neat_setting)
