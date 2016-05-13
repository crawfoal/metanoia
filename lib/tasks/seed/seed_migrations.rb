require_relative 'migrator'

module SeedMigrations
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    attr_reader :migrator
    def migrator
      @migrator ||= Migrator.new
    end

    def run_outstanding_migrations
      migrator.run_outstanding_migrations
    end

    def regenerate_yaml_seed_files
      migrator.regenerate_yaml_seed_files
    end
  end

  class Configuration
    attr_accessor :seeded_tables

    def initialize
      @seeded_tables = []
    end
  end
end
