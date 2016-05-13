require 'rails_helper'
require 'rake'
require 'fileutils'

RSpec.describe 'seed:migrate' do
  include SeedMigrateHelper

  before :all do
    Rake.application.rake_require 'tasks/seed/migrate'
    Rake::Task.define_task(:environment)
  end

  before :each do
    SeedMigrations.configure {}
    allow(SeedMigrations.configuration).to \
      receive(:seeded_tables).and_return([:users])
  end

  def run_rake_task
    Rake::Task['seed:migrate'].reenable
    Rake.application.invoke_task 'seed:migrate'
  end

  context 'when there is a file in `db/seeds/migrate` that is not in the'\
          '`seed_migrations` table' do
    before :each do
      prepare_migrations
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
      base_file_names = Dir["#{Rails.root}/db/seeds/data/*.yml"].map do |f_name|
        File.basename(f_name)
      end
      expect(base_file_names).to include 'users.yml'
    end

    after :each do
      cleanup_migrations
    end
  end
end
