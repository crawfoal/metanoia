require 'database_cleaner'

module DatabaseCleanerHelper
  def self.truncation_except_seeded_tables
    [
      :truncation,
      { except: SeedMigrations.configuration.seeded_tables.map(&:to_s) }
    ]
  end
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    if config.use_transactional_fixtures?
      raise(<<-MSG)
        Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
        (or set it to false) to prevent uncommitted transactions being used in
        JavaScript-dependent specs.

        During testing, the app-under-test that the browser driver connects to
        uses a different database connection to the database connection used by
        the spec. The app's database connection would not be able to access
        uncommitted transaction data setup over the spec's database connection.
      MSG
    end
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs =
      Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      DatabaseCleaner.strategy =
        DatabaseCleanerHelper.truncation_except_seeded_tables
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end
