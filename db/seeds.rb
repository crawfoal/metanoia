require_relative 'seed_data/seed_data'

SeedData.clear_all_seeded_tables
SeedData::GradeSystems.create_hueco
SeedData::GradeSystems.create_yds
