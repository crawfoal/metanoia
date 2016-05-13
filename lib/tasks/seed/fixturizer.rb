require "#{Rails.root}/lib/file_utils_supplement"

module Fixturizer
  extend ActiveSupport::Concern

  module ClassMethods
    def to_fixtures
      h = {}
      singular_table_name = table_name.singularize
      find_each do |record|
        h["#{singular_table_name}_#{record.id}"] =
          record.attributes.except('created_at', 'updated_at')
      end
      h.to_yaml
    end

    def export_fixtures(into:)
      file_name = "#{into}/#{table_name}.yml"
      FileUtilsSupplement.find_or_create_directory(into)
      File.open(file_name, 'w') do |file|
        file.write to_fixtures
      end
    end
  end
end
