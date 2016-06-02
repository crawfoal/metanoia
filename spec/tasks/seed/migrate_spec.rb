require 'rails_helper'
require 'rake'
require_relative 'seed_migrations_helper'

RSpec.describe 'seed:migrate', type: :task do
  include SeedMigrationsHelper

  before :all do
    Rake.application.rake_require 'tasks/seed/migrate'
    Rake::Task.define_task(:environment)

    intialize_seed_migrations_library
    set_folder_paths
    delete_temporary_files
  end

  context 'when there is a file in `db/seeds/migrate` that is not in the'\
          '`seed_migrations` table' do
    before :each do
      pretend_seeded_tables_are :users
      mock_seed_migrations_root_directory_as "#{Rails.root}/tmp"
      copy_all_files from: @sample_migrations_folder, to: @migration_folder
    end

    it 'it runs the code defined in the `up` method' do
      expect { run_rake_task('seed:migrate') }.to change { User.count }.by(1)
    end

    it 'stores the file name in the table' do
      expect { run_rake_task('seed:migrate') }.to \
        change { SeedMigration.count }.by(2)
    end

    it 'runs the migrations in order, according to the timestamp' do
      run_rake_task('seed:migrate')
      expect(User.find_by_email('sam@example.com')).to_not be_present
    end

    describe 'the yaml files created for the seeded tables' do
      it 'are created' do
        run_rake_task('seed:migrate')
        base_file_names = Dir[@fixture_folder + '/*.yml'].map do |file_name|
          File.basename(file_name)
        end
        expect(base_file_names).to include 'users.yml'
      end

      it 'include the yaml representation of each model in the table' do
        run_rake_task('seed:migrate')
        Dir[@fixture_folder + '/*.yml'].each do |file_name|
          file_contents = File.read(file_name)
          table_name = File.basename(file_name, '.yml')
          model_name = table_name.singularize.classify
          expect(file_contents).to eq model_name.constantize.to_fixtures
        end
      end
    end

    after :each do
      delete_temporary_files
    end
  end
end
