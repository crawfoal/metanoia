namespace :db do
  desc "Fills database with sample data"
  task :populate => :protected do
    Dir[Rails.root.join('db/sample_data/**/*.rb')].each { |f| require f }

    Rake::Task['db:reset'].invoke

    FactoryGirl.create(:wild_walls, climb_factory: :boulder)
    FactoryGirl.create(:boulders_climbing_gym, climb_factory: :boulder)
    FactoryGirl.create(:movement_boulder, climb_factory: :route)
    FactoryGirl.create(:the_spot, climb_factory: :boulder)
    FactoryGirl.create(:sample_gym)
  end
end
