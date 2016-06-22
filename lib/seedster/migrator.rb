module Seedster
  class Migrator
    def initialize(config)
      @root_directory = config.root_directory
      @migration_directory = config.migration_directory
      @version_filename = config.version_filename
    end

    def run_outstanding_migrations
      new_current_version = ''
      migration_files.each do |migration_file|
        if migration_file.version > current_version
          migration_file.instantiate_migration.up
          new_current_version = migration_file.version
        end
      end
      record_version(new_current_version) unless new_current_version.blank?
    end

    def rollback_one_migration
      current_version_migration_file.instantiate_migration.down
    end

    private

    def current_version
      @_cv ||= File.file?(@version_filename) ? File.read(@version_filename) : ''
    end

    def migration_files
      Dir["#{@migration_directory}/*.rb"].map do |filename|
        MigrationFile.new(filename)
      end
    end

    def current_version_migration_file
      filename = Dir["#{@migration_directory}/#{current_version}_*.rb"].first
      filename.present? ? MigrationFile.new(filename) : NullMigrationFile.new
    end

    def record_version(version)
      File.write(@version_filename, version)
    end
  end
end
