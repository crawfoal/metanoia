require_relative 'migrator'
require "#{Rails.root}/lib/table_dependency_graph"

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

    def rollback_one_migration
      migrator.rollback_one_migration
    end

    def regenerate_yaml_seed_files
      migrator.regenerate_yaml_seed_files
    end
  end

  class Configuration
    attr_writer :seeded_tables

    def initialize
      @seeded_tables = []
    end

    def seeded_tables
      TableDependencyGraph.new(*@seeded_tables).tsort
    end
  end
end
