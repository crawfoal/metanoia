class SeedMigration < ActiveRecord::Base
  after_save do |seed_migration|
    base_file_name = File.basename(filename, '.rb')
    version = base_file_name.partition('_').first
    File.write(
      "#{SeedMigrations.migrator.root_directory}/db/seeds/seeds_version.rb",
      version
    )
  end
end
