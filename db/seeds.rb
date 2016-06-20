require 'active_record/fixtures'

ActiveRecord::Base.transaction do
  ActiveRecord::Base.connection.execute("SET CONSTRAINTS ALL DEFERRED")
  ActiveRecord::FixtureSet.create_fixtures(
    SeedMigrations.migrator.fixture_directory,
    SeedMigrations.configuration.seeded_tables
  )
end
