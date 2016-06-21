require 'rails_helper'
require_relative 'seed_migrations_helper'

RSpec.describe SeedMigrations do
  include SeedMigrationsHelper

  describe '.configuration.seeded_tables' do
    it 'returns the tables, ordered by dependencies (i.e. if table A has a fk '\
       'pointing to table B, then table B will come before table A in the '\
       'list)' do
      SeedMigrations.configure do |config|
        config.seeded_tables = [:grade_systems, :grades, :buckets]
      end
      expect(SeedMigrations.configuration.seeded_tables.last).to eq 'grades'
    end
  end
end
