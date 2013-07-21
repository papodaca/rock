# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rock::Application.initialize!

# Load the config.yml file into the constant for easy access
$APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")