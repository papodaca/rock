# Load the rails application
require File.expand_path('../application', __FILE__)

#Workling::Remote.dispatcher = Workling::Remote::Runners::BackgroundjobRunner.new

# Initialize the rails application
Rock::Application.initialize!

APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")