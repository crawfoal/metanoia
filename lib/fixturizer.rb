require "#{Rails.root}/lib/file_utils_supplement"

module Fixturizer
  extend ActiveSupport::Concern

  def fixture_key
    "#{self.class.table_name.singularize}_#{id}"
  end

  def fixture_value
    attributes.except('created_at', 'updated_at')
  end

  module ClassMethods
    def to_fixtures
      h = {}
      find_each do |record|
        h[record.fixture_key] = record.fixture_value
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
