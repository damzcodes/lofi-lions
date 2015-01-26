ENV['RAILS_ENV'] = 'test'
require './config/environment'
require 'rspec/rails'
require 'factory_girl_rails'
require 'faker'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

Spinach.hooks.before_scenario{ DatabaseCleaner.clean }

Spinach.config.save_and_open_page_on_failure = true
