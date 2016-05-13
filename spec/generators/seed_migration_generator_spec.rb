require 'generator_helper'
require "#{Rails.root}/lib/generators/seed_migration/seed_migration_generator"

RSpec.describe SeedMigrationGenerator, type: :generator do
  before :each do
    destination File.expand_path(default_destination, __FILE__)
    prepare_destination
    run_generator %w(AddUsers)
  end

  subject { migration_file 'db/seeds/migrate/add_users.rb' }

  it { should be_a_migration }
  it { should have_correct_syntax }
  it { should contain /class AddUsers/ }
  it { should contain /def up/ }
  it { should contain /def down/ }

  after(:all) { delete_temporary_files }
end
