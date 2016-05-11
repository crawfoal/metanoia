module SeedMigrateHelper
  def prepare_migrations
    @seeds_migrate_folder = "#{Rails.root}/db/seeds/migrate"
    @sample_migrations_folder =
      "#{Rails.root}/spec/tasks/seed/sample_migrations"
    @sample_migration_files = []
    Dir[@sample_migrations_folder + '/*.rb'].each do |file_name|
      destination = @seeds_migrate_folder + '/' + File.basename(file_name)
      FileUtils.cp( file_name, destination)
      @sample_migration_files << file_name
    end
  end

  def cleanup_migrations
    @sample_migration_files.each do |file_name|
      FileUtils.rm(@seeds_migrate_folder + '/' + File.basename(file_name))
    end
  end
end
