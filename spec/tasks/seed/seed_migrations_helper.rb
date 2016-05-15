module SeedMigrationsHelper
  def intialize_seed_migrations_library
    # Make sure the configuration and migrator are intialized so we can mock
    # some of their methods in a `before :each` hook.
    SeedMigrations.configure {}
    SeedMigrations.migrator
  end

  def set_folder_paths
    @migration_folder = "#{Rails.root}/tmp/db/seeds/migrate"
    @sample_migrations_folder = "#{Rails.root}/spec/tasks/seed/sample_migrations"
    @fixture_folder = "#{Rails.root}/tmp/db/seeds/data"
  end

  def pretend_seeded_tables_are(*table_names)
    allow(SeedMigrations.configuration).to \
      receive(:seeded_tables).and_return(table_names)
  end

  def mock_seed_migrations_root_directory_as(directory_path)
    allow(SeedMigrations.migrator).to \
      receive(:root_directory).and_return(directory_path)
  end
end
