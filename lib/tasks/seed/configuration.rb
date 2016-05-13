module SeedMigrations
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :seeded_tables

    def initialize
      @seeded_tables = []
    end
  end
end
