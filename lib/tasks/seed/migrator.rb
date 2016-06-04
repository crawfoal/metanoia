require_relative 'seed_migration'
require 'fileutils'
require_relative 'fixturizer'

module SeedMigrations
  class Migrator
    def initialize
      @queue = {}
    end

    def run_outstanding_migrations
      queue_up_migrations
      @queue.sort.each do |file_name, migration|
        migration.up
        SeedMigration.create!(filename: file_name)
      end
    end

    def rollback_one_migration
      last_migration_filename = SeedMigration.order(:filename).last.filename
      last_migration = instantiate_migration(last_migration_filename)
      last_migration.down
      SeedMigration.find_by_filename(last_migration_filename).destroy
    end

    def regenerate_yaml_seed_files
      SeedMigrations.configuration.seeded_tables.each do |table_name|
        klass = table_name.to_s.singularize.classify.constantize
        klass.include Fixturizer
        klass.export_fixtures into: fixture_directory
      end
    end

    def fixture_directory
      root_directory + '/db/seeds/data'
    end

    private

    def root_directory
      # :nocov:
      Rails.root.to_s
      # :nocov:
    end

    def migration_directory
      root_directory + '/db/seeds/migrate'
    end

    def queue_up_migrations
      migration_files.each do |file_name|
        next unless SeedMigration.find_by_filename(file_name).blank?
        @queue[file_name] = instantiate_migration(file_name)
      end
    end

    def instantiate_migration(file_name)
      require file_name
      _version, class_name = parse_file_name(file_name)
      class_name.constantize.new
    end

    def parse_file_name(file_name)
      base_file_name = File.basename(file_name, '.rb')
      version, _underscore, class_name = base_file_name.partition('_')
      [version, class_name.classify]
    end

    def migration_files
      Dir["#{migration_directory}/**/*.rb"]
    end
  end
end
