require_relative 'seed_migrations'

namespace :seed do
  desc 'generates the yaml seed files based on the current state of the '\
       'seeded tables in the database'
  task generate_seed_files: :environment do
    SeedMigrations.regenerate_yaml_seed_files
  end
end
