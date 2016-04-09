require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'
RSpec.configure do |config|
  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      DatabaseCleaner.strategy = :truncation
    end
  end
end
