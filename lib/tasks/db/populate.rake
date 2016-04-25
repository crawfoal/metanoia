require_relative 'populate'

namespace :db do
  desc "Resets the database and then fills it with sample data"
  task :populate => [:protected, :reset, :fill]

  desc "Fill the database with sample data"
  task :fill => [:environment] do
    Tasks::DB::Populate.fill_database
  end
end
