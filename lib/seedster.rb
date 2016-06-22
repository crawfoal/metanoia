require_relative "seedster/configuration"
require_relative "seedster/migrator"
require_relative "seedster/migration_file"
require "#{Rails.root}/lib/table_dependency_graph"
require "#{Rails.root}/lib/fixturizer"

module Seedster
  class << self
    def configure
      @configuration ||= Configuration.new
      yield(@configuration)
    end

    delegate :fixture_directory, :root_directory, :migration_directory,
             :version_filename, to: :@configuration

    def tables
      TableDependencyGraph.new(*@configuration.tables).tsort
    end

    def fill_tables
      ActiveRecord::FixtureSet.create_fixtures(fixture_directory, tables)
    end

    def migrate
      Migrator.new(@configuration).run_outstanding_migrations
      generate_seeds
    end

    def rollback
      Migrator.new(@configuration).rollback_one_migration
      generate_seeds
    end

    def generate_seeds
      tables.each do |table_name|
        klass = table_name.to_s.singularize.classify.constantize
        klass.include Fixturizer
        klass.export_fixtures into: fixture_directory
      end
    end
  end
end
