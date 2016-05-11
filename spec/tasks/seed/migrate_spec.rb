require 'rails_helper'
require 'rake'
require 'fileutils'

RSpec.describe 'seed:migrate' do
  include SeedMigrateHelper
  
  before :all do
    Rake.application.rake_require 'tasks/seed/migrate'
    Rake::Task.define_task(:environment)
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

    after :each do
      cleanup_migrations
    end
  end
end
