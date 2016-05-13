require_relative 'migrator'

namespace :seed do
  desc 'run outstanding migrations, and regenerate the seed data files'
  task migrate: :environment do
    migrator = SeedMigrations::Migrator.new
    SeedMigrations.configure do |config|
      config.seeded_tables = [:grade_systems, :grades]
    end
    migrator.run_outstanding_migrations
    migrator.regenerate_yaml_seed_files
  end
end
