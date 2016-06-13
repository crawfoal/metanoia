require 'rails_helper'
require 'rake'
require_relative 'seed_migrations_helper'

RSpec.describe 'seed:generate_yaml_seed_files', type: :task do
  include SeedMigrationsHelper

  before :all do
    Rake.application.rake_require 'tasks/seed/generate_seed_files'
    Rake::Task.define_task(:environment)

    intialize_seed_migrations_library
    set_folder_paths
    delete_temporary_files
  end

  before :each do
    pretend_seeded_tables_are :users
    mock_seed_migrations_root_directory_as "#{Rails.root}/tmp"
    copy_all_files from: @sample_migrations_folder, to: @migration_folder
  end

  it 'creates the yaml seed files' do
    run_rake_task('seed:generate_seed_files')
    base_file_names = Dir[@fixture_folder + '/*.yml'].map do |file_name|
      File.basename(file_name)
    end
    expect(base_file_names).to include 'users.yml'
  end
end
