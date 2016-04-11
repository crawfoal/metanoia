namespace :db do
  desc "Fills database with sample data"
  task :populate => :protected do
    Dir[Rails.root.join('db/sample_data/**/*.rb')].each { |f| require f }

    Rake::Task['db:reset'].invoke

    gym_factories = [
      :wild_walls,
      :boulders_climbing_gym,
      :movement_boulder,
      :the_spot
    ]
    gym_factories.each { |factory_name| FactoryGirl.create(factory_name) }
  end
end
