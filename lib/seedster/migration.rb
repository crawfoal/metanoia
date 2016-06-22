module Seedster
  class Migration
    def initialize(filename)
      @filename = filename
    end

    def version
      parse_file_name.first
    end

    def instantiate
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
end
