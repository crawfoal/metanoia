require "#{Rails.root}/lib/tasks/seed/seed_migrations"

SeedMigrations.configure do |config|
  config.seeded_tables = [:grade_systems, :grades, :buckets]
end
