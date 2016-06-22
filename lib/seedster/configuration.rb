module Seedster
  class Configuration
    def initialize
      @tables = []
      @root_directory = Rails.root.to_s + '/db/seeds'
    end

    def fixture_directory
      root_directory + '/data'
    end

    def migration_directory
      root_directory + '/migrate'
    end

    def version_filename
      root_directory + '/seeds_version.rb'
    end

    attr_accessor :root_directory, :tables
  end
end
