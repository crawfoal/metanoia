require_relative 'seedster/configuration'
require_relative 'seedster/migrator'
require_relative 'seedster/migration_file'
require "#{Rails.root}/lib/table_dependency_graph"
require "#{Rails.root}/lib/fixturizer"
require 'active_record/fixtures'
require_relative 'seedster/active_record_helpers'
require_relative 'seedster/referential_integrity_patch'

module Seedster
  class << self
    def configure
      @configuration ||= Configuration.new
      yield(@configuration)
      reset
    end

    delegate :fixture_directory, :root_directory, :migration_directory,
             :version_filename, to: :@configuration

    delegate :migrating?, :current_version, to: :migrator

    def tables
      TableDependencyGraph.new(*@configuration.tables).tsort
    end

    def fill_tables
      # waiting on Rails PR #21233 - then can go back to simple one liner that
      # is in the else block
      # (see Seedster::ReferentialIntegrityPatch for transaction wrapper method)
      ActiveRecord::Base.connection.disable_referential_integrity do
        ActiveRecord::FixtureSet.create_fixtures(fixture_directory, tables)
      end
    end

    def migrate
      migrator.run_outstanding_migrations
      generate_seeds
    end

    def rollback
      migrator.rollback_one_migration
      generate_seeds
    end

    def generate_seeds
      tables.each do |table_name|
        klass = table_name.to_s.singularize.classify.constantize
        klass.include Fixturizer
        klass.export_fixtures into: fixture_directory
      end
    end

    def migrator
      @migrator ||= Migrator.new(@configuration)
    end

    def reset
      @migrator = nil
    end
  end
end
