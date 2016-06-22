require 'rails_helper'
require "#{Rails.root}/lib/seedster"

RSpec.describe Seedster do
  before :each do
    delete_temporary_files
    Seedster.configure do |config|
      config.tables = [:users]
      config.root_directory = "#{Rails.root}/tmp"
    end
    copy_all_files from: "#{Rails.root}/spec/tasks/seed/sample_migrations",
                   to: Seedster.migration_directory
  end

  let(:version_filename) do
    Seedster.root_directory + '/db/seeds/seeds_version.rb'
  end

  describe '.tables' do
    before :each do
      Seedster.configure do |config|
        config.tables = [:grade_systems, :grades, :buckets]
      end
    end

    it 'includes all tables listed in the configuration' do
      expect(Seedster.tables).to include('grade_systems', 'grades', 'buckets')
    end

    it 'lists parent tables before child tables' do
      expect(Seedster.tables.last).to eq 'grades'
    end
  end

  describe '.fill_tables' do
    before :each do
      Seedster.configure do |config|
        config.tables = [:grade_systems, :grades, :buckets]
        config.root_directory = Rails.root.to_s
      end
    end

    it 'populates the seeded tables with the data in the fixture files' do
      Grade.destroy_all
      Bucket.destroy_all
      GradeSystem.destroy_all
      expect { Seedster.fill_tables }.to change { GradeSystem.count }.from(0)
    end
  end

  describe '.rollback_one_migration' do
    it 'reverts the most recent migration if there is a version file' do
      Seedster.run_outstanding_migrations
      Seedster.rollback_one_migration
      expect(User.find_by_email('sam@example.com')).to_not be_present
      expect(User.find_by_email('amanda@example.com')).to be_present
      expect(User.find_by_email('tj@example.com')).to_not be_present
    end

    it 'does nothing if there is no version file' do
      expect { Seedster.rollback_one_migration }.to_not \
        change { User.count }.from(0)
    end
  end

  describe '.regenerate_yaml_seed_files' do
    it 'rebuilds the yaml seed files using the data currently in the tables'
  end

  describe '.run_outstanding_migrations' do
    it 'runs all migrations when there is no version file' do
      Seedster.run_outstanding_migrations
      expect(User.find_by_email('sam@example.com')).to_not be_present
      expect(User.find_by_email('amanda@example.com')).to be_present
      expect(User.find_by_email('tj@example.com')).to be_present
    end

    it 'runs only outstanding migrations when there is a version file' do
      File.write(version_filename, '20170511115239')
      Seedster.run_outstanding_migrations
      expect(User.find_by_email('sam@example.com')).to_not be_present
      expect(User.find_by_email('amanda@example.com')).to_not be_present
      expect(User.find_by_email('tj@example.com')).to be_present
    end

    it 'saves the current version to a file' do
      Seedster.run_outstanding_migrations
      expect(File.read(version_filename)).to eq '20180511115239'
    end

    it 'does not modify the current version if no migrations were run' do
      File.write(version_filename, '20180511115239')
      Seedster.run_outstanding_migrations
      expect(File.read(version_filename)).to eq '20180511115239'
    end
  end
end
