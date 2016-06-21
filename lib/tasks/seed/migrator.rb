require_relative 'seed_migration'
require 'fileutils'
require_relative 'fixturizer'

module SeedMigrations
  class Migrator
    def initialize
      @queue = {}
    end

    def run_outstanding_migrations
      check_seeds_version
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

    def root_directory
      # :nocov:
      Rails.root.to_s
      # :nocov:
    end

    private

    def version_file_name
      root_directory + '/db/seeds/seeds_version.rb'
    end

    def seed_migration_table_current_version
      last_migration = SeedMigration.order(:created_at).last
      return unless last_migration
      parse_file_name(last_migration.filename).first
    end

    def check_seeds_version
      return unless File.file? version_file_name
      current_version = File.read(version_file_name)
      return if seed_migration_table_current_version == current_version
      migration_files.each do |file_name|
        SeedMigration.find_or_create_by!(filename: file_name)
        break if parse_file_name(file_name).first == current_version
      end
    end

    def migration_directory
      root_directory + '/db/seeds/migrate'
    end

    def queue_up_migrations
      @queue = {}
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
      [version, class_name.camelize]
    end

    def migration_files
      Dir["#{migration_directory}/**/*.rb"]
    end
  end
end
