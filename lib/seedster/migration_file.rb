module Seedster
  class MigrationFile
    def initialize(filename)
      @filename = filename
    end

    def version
      parse_file_name.first
    end

    def instantiate_migration
      require @filename
      class_name.constantize.new
    end

    private

    def parse_file_name
      base_filename = File.basename(@filename, '.rb')
      version, _underscore, class_name = base_filename.partition('_')
      [version, class_name.camelize]
    end

    def class_name
      parse_file_name.last
    end
  end

  class NullMigrationFile
    def initialize
    end

    def instantiate_migration
      NullMigration.new
    end
  end

  class NullMigration
    def up
    end

    def down
    end
  end
end
