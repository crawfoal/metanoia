require_relative 'seed_migrations'

namespace :seed do
  desc 'run outstanding migrations, and regenerate the seed data files'
  task migrate: :environment do
    SeedMigrations.run_outstanding_migrations
    SeedMigrations.regenerate_yaml_seed_files
  end
end
