require_relative "seedster/configuration"
require_relative "seedster/migrator"
require_relative "seedster/migration_file"
require "#{Rails.root}/lib/table_dependency_graph"

module Seedster
  class << self
    def configure
      @configuration ||= Configuration.new
      yield(@configuration)
    end

    delegate :fixture_directory, :root_directory, :migration_directory,
             to: :@configuration

    def tables
      TableDependencyGraph.new(*@configuration.tables).tsort
    end

    def fill_tables
      ActiveRecord::FixtureSet.create_fixtures(fixture_directory, tables)
    end

    def run_outstanding_migrations
      Migrator.new(@configuration).run_outstanding_migrations
    end

    def rollback_one_migration
      Migrator.new(@configuration).rollback_one_migration
    end
  end
end
