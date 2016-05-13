require_relative 'seed_migration'
require 'fileutils'

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

    def regenerate_yaml_seed_files
      unless File.directory?(fixture_directory)
        FileUtils.mkdir_p(fixture_directory)
      end
      SeedMigrations.configuration.seeded_tables.each do |table_name|
        File.open("#{fixture_directory}/#{table_name}.yml", 'w') do |file|
        end
      end
    end

    private

    def root_directory
      # :nocov:
      Rails.root
      # :nocov:
    end

    def migration_directory
      root_directory + '/db/seeds/migrate'
    end

    def fixture_directory
      root_directory + '/db/seeds/data'
    end

    def queue_up_migrations
      migration_files.each do |file_name|
        next unless SeedMigration.find_by_filename(file_name).blank?
        add_migration_to_queue(file_name)
      end
    end

    def add_migration_to_queue(file_name)
      require file_name
      version, class_name = parse_file_name(file_name)
      @queue[file_name] = class_name.constantize.new
    end

    def parse_file_name(file_name)
      base_file_name = File.basename(file_name, '.rb')
      version, underscore, class_name = base_file_name.partition('_')
      [version, class_name.classify]
    end

    def migration_files
      Dir["#{migration_directory}/**/*.rb"]
    end
  end
end
