require 'active_record/fixtures'

ActiveRecord::FixtureSet.create_fixtures(
  SeedMigrations.migrator.fixture_directory,
  SeedMigrations.configuration.seeded_tables
)
