require 'task_helper'
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

  describe 'version file', type: :task do
    it 'records the version of the most recent seed migration that has been applied' do
      intialize_seed_migrations_library
      set_folder_paths
      delete_temporary_files
      pretend_seeded_tables_are :users
      mock_seed_migrations_root_directory_as "#{Rails.root}/tmp"
      copy_all_files from: @sample_migrations_folder, to: @migration_folder

      run_rake_task('seed:migrate')

      version_file_contents = File.read("#{Rails.root}/tmp/db/seeds/seeds_version.rb")
      expect(version_file_contents).to eq '20180511115239'
    end
  end
end
