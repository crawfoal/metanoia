require 'rails/generators'

class SeedMigrationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate
    template 'seed_migration.rb.erb',
      "db/seeds/migrate/#{timestamp}_#{file_name_suffix}.rb"
  end

  private

  def file_name_suffix
    name.underscore
  end

  def class_name
    name.camelize
  end

  def timestamp
    Time.now.strftime("%Y%m%d%H%M%S")
  end
end
