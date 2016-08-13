module Seedster
  class Migrator
    def initialize(config)
      @root_directory = config.root_directory
      @migration_directory = config.migration_directory
      @version_filename = config.version_filename
      @is_migrating = false
    end

    def run_outstanding_migrations
      new_current_version = ''

      with_migration_flag do
        migration_files.each do |migration_file|
          if migration_file.version > current_version
            migration_file.instantiate_migration.up
            new_current_version = migration_file.version
          end
        end
      end

      record_version(new_current_version) unless new_current_version.blank?
    end

    def rollback_one_migration
      with_migration_flag do
        current_version_migration_file.instantiate_migration.down
      end

      record_version(previous_version)
    end

    def migrating?
      @is_migrating
    end

    def current_version
      File.file?(@version_filename) ? File.read(@version_filename) : ''
    end

    private

    def with_migration_flag
      @is_migrating = true
      yield
      @is_migrating = false
    end

    def migration_files
      migration_filenames.map do |filename|
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

    def previous_version
      if file_index_for_current_version
        migration_base_filenames[file_index_for_current_version - 1].
          match(/^(\d+)_.+$/)[1]
      else
        ''
      end
    end

    def migration_filenames
      Dir["#{@migration_directory}/*.rb"]
    end

    def migration_base_filenames
      migration_filenames.map { |filename| File.basename(filename) }
    end

    def file_index_for_current_version
      migration_base_filenames.index do |filename|
        filename.match(/^#{current_version}_.+$/)
      end
    end
  end
end
