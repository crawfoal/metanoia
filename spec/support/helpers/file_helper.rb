require 'fileutils'
require 'file_utils_supplement'

module FileHelper
  def delete_temporary_files
    clear_out_folder("#{Rails.root}/tmp")
  end

  def clear_out_folder(folder_path)
    FileUtils.rm_rf(Dir.glob(folder_path + '/*'))
  end

  def copy_all_files(from:, to:)
    FileUtilsSupplement.find_or_create_directory(to)
    Dir[from + '/*'].each do |original_file_name|
      new_file_name = to + '/' + File.basename(original_file_name)
      FileUtils.cp(original_file_name, new_file_name)
    end
  end
end

RSpec.configure do |config|
  config.include FileHelper
end
