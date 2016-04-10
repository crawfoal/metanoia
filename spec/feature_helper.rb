require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'
Dir[Rails.root.join('spec/features/support/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/features/support/configurations/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      DatabaseCleaner.strategy = :truncation
    end
  end
end
