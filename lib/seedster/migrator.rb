module Seedster
  class Migrator
    def initialize(config)
      @root_directory = config.root_directory
      @migration_directory = config.migration_directory
    end

    def run_outstanding_migrations
      migrations.each do |migration|
        if migration.version > current_version
          migration.instantiate.up
        end
      end
    end

    private

    def version_filename
      @root_directory + '/db/seeds/seeds_version.rb'
    end

    def current_version
      @_cv ||= File.file?(version_filename) ? File.read(version_filename) : ''
    end

    def migrations
      Dir["#{@migration_directory}/**/*.rb"].map do |filename|
        Migration.new(filename)
      end
    end
  end
end
