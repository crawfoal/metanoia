module SeedMigration
  class Migrator
    class << self
      def puts(*args)
        # override this with an empty method to prevent SeedMigration from
        # writing output during specs
      end
      alias_method :p, :puts
    end
  end
end
