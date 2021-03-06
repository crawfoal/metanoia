require 'rails_helper'
require "#{Rails.root}/lib/seedster"

RSpec.describe Seedster do
  context 'using sample files and temp folder' do
    before :each do
      delete_temporary_files
      Seedster.configure do |config|
        allow(config).to receive(:tables).and_return([:users])
        allow(config).to receive(:root_directory).and_return(
          "#{Rails.root}/tmp/db/seeds")
      end
      copy_all_files from: "#{Rails.root}/spec/lib/seedster/sample_migrations",
                     to: Seedster.migration_directory
    end

    def version_filename
      Seedster.version_filename
    end

    def fixture_filename
      Seedster.fixture_directory + '/users.yml'
    end

    describe '.rollback' do
      it 'reverts the most recent migration if there is a version file' do
        Seedster.migrate
        Seedster.rollback
        expect(User.find_by_email('sam@example.com')).to_not be_present
        expect(User.find_by_email('amanda@example.com')).to be_present
        expect(User.find_by_email('tj@example.com')).to_not be_present
      end

      it 'does nothing if there is no version file' do
        expect { Seedster.rollback }.to_not \
          change { User.count }.from(0)
      end

      it 'updates the seeds' do
        Seedster.migrate
        expect { Seedster.rollback }.to change { File.read(fixture_filename) }
      end

      it 'updates the current version' do
        Seedster.migrate
        expect { Seedster.rollback }.to \
          change { Seedster.current_version }.to('20170511115239')
      end
    end

    describe '.generate_seeds' do
      it 'builds the yaml seed files using the data currently in the tables' do
        create :user
        expect { Seedster.generate_seeds }.to \
          change { File.file? fixture_filename }
        expect(File.read(fixture_filename)).to eq User.to_fixtures
      end
    end

    describe '.migrate' do
      it 'runs all migrations when there is no version file' do
        Seedster.migrate
        expect(User.find_by_email('sam@example.com')).to_not be_present
        expect(User.find_by_email('amanda@example.com')).to be_present
        expect(User.find_by_email('tj@example.com')).to be_present
      end

      it 'runs only outstanding migrations when there is a version file' do
        File.write(version_filename, '20170511115239')
        Seedster.migrate
        expect(User.find_by_email('sam@example.com')).to_not be_present
        expect(User.find_by_email('amanda@example.com')).to_not be_present
        expect(User.find_by_email('tj@example.com')).to be_present
      end

      it 'saves the current version to a file' do
        Seedster.migrate
        expect(File.read(version_filename)).to eq '20180511115239'
      end

      it 'does not modify the current version if no migrations were run' do
        File.write(version_filename, '20180511115239')
        Seedster.migrate
        expect(File.read(version_filename)).to eq '20180511115239'
      end

      it 'saves the seeded tables to YAML files' do
        expect { Seedster.migrate }.to \
          change { File.file? fixture_filename }.to(true)
      end
    end
  end

  # !!! Tests outside of the above context (could) interract with the actual
  # !!! seed files in this application!

  describe '.tables' do
    it 'includes all tables listed in the configuration, with parents listed '\
       'before children' do
      Seedster.configure do |config|
        allow(config).to receive(:tables).
          and_return([:employments, :setter_stories])
      end

      expect(Seedster.tables).to eq %w(setter_stories employments)
    end
  end

  describe '.fill_tables' do
    it 'populates the seeded tables with the data in the fixture files' do
      Seedster.configure do |config|
        allow(config).to receive(:tables).and_return([:grades])
      end
      Grade.destroy_all

      expect { Seedster.fill_tables }.to change { Grade.count }.from(0)
    end
  end
end
