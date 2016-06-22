module Seedster
  class Configuration
    def initialize
      @tables = []
      @root_directory = Rails.root.to_s
    end

    def fixture_directory
      root_directory + '/db/seeds/data'
    end

    def migration_directory
      root_directory + '/db/seeds/migrate'
    end

    attr_accessor :root_directory, :tables
  end
end
