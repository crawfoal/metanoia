require 'fileutils'

module FileUtilsSupplement
  class << self
    def find_or_create_directory(directory_path)
      unless File.directory?(directory_path)
        FileUtils.mkdir_p(directory_path)
      end
    end
  end
end
