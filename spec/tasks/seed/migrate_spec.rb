require 'rails_helper'
require 'rake'

RSpec.describe 'seed:migrate' do
  before :all do
    Rake.application.rake_require 'tasks/seed/migrate'
    Rake::Task.define_task(:environment)

    intialize_seed_migrations
    set_folder_paths
    delete_temporary_files
  end

  before :each do
    allow(SeedMigrations.configuration).to \
      receive(:seeded_tables).and_return([:users])
    allow(SeedMigrations.migrator).to \
      receive(:root_directory).and_return("#{Rails.root}/tmp")
  end

  context 'when there is a file in `db/seeds/migrate` that is not in the'\
          '`seed_migrations` table' do
    before :each do
      copy_all_files from: @sample_migrations_folder, to: @migration_folder
    end

    it 'it runs the code defined in the `up` method' do
      expect { run_rake_task }.to change { User.count }.by(1)
    end

    it 'stores the file name in the table' do
      expect { run_rake_task }.to change { SeedMigration.count }.by(2)
    end

    it 'runs the migrations in order, according to the timestamp' do
      run_rake_task
      expect(User.find_by_email 'sam@example.com').to_not be_present
    end

    it 'creates yaml files for the tables that are populated with seeds' do
      run_rake_task
      base_file_names = Dir[@fixture_folder + '/*.yml'].map do |f_name|
        File.basename(f_name)
      end
      expect(base_file_names).to include 'users.yml'
    end

    after :each do
      delete_temporary_files
    end
  end

  def run_rake_task
    Rake::Task['seed:migrate'].reenable
    Rake.application.invoke_task 'seed:migrate'
  end

  def intialize_seed_migrations
    # Make sure the configuration and migrator are intialized so we can mock
    # some of their methods in a `before :each` hook.
    SeedMigrations.configure {}
    SeedMigrations.migrator
  end

  def set_folder_paths
    @migration_folder = "#{Rails.root}/tmp/db/seeds/migrate"
    @sample_migrations_folder = "#{Rails.root}/spec/tasks/seed/sample_migrations"
    @fixture_folder = "#{Rails.root}/tmp/db/seeds/data"
  end
end
