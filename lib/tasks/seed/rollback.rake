require_relative 'seed_migrations'

namespace :seed do
  desc 'rollback the last migration, and regenerate the seed data files'
  task rollback: :environment do
    SeedMigrations.rollback_one_migration
    SeedMigrations.regenerate_yaml_seed_files
  end
end
