require 'task_helper'
require_relative 'seed_migrations_helper'

RSpec.describe 'seed:rollback', type: :task do
  include SeedMigrationsHelper

  before :all do
    intialize_seed_migrations_library
    set_folder_paths
    delete_temporary_files
  end

  context 'when there is at least one completed migration' do
    before :each do
      pretend_seeded_tables_are :users
      mock_seed_migrations_root_directory_as "#{Rails.root}/tmp"
      copy_all_files from: @sample_migrations_folder, to: @migration_folder
      run_rake_task('seed:migrate')
    end

    it 'runs the code defined in the `down` method of the last migration' do
      expect { run_rake_task('seed:rollback') }.to \
        change { User.find_by_email 'amanda@example.com' }.to(nil)
    end

    it 'removes the migration record from the table' do
      expect { run_rake_task('seed:rollback') }.to \
        change { SeedMigration.count }.by(-1)
    end

    it 'regenerates the yaml seed files' do
      amanda = User.find_by_email 'amanda@example.com'
      amanda_yaml = { amanda.fixture_key => amanda.fixture_value }.to_yaml
      run_rake_task('seed:rollback')
      file_contents = File.read(@fixture_folder + '/users.yml')
      expect(file_contents).to_not include amanda_yaml
    end
  end

  after :each do
    delete_temporary_files
  end
end
