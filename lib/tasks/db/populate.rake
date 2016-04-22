namespace :db do
  desc "Fills database with sample data"
  task :populate => :protected do
    Dir[Rails.root.join('db/sample_data/**/*.rb')].each { |f| require f }

    Rake::Task['db:reset'].invoke

    gym_factories = {
      wild_walls: :boulder,
      boulders_climbing_gym: :boulder,
      movement_boulder: :route,
      the_spot: :boulder
    }
    gym_factories.each do |factory_name, climb_factory|
      gym = FactoryGirl.create(factory_name)
      gym.sections.each do |section|
        Faker::Number.between(5, 15).times do
          FactoryGirl.create(climb_factory, :with_color, :with_grade, section: section)
        end
        Faker::Number.between(1, 3).times do
          FactoryGirl.create(climb_factory, :with_color, section: section)
        end
        Faker::Number.between(1, 3).times do
          FactoryGirl.create(climb_factory, :with_grade, section: section)
        end
      end
    end
  end
end
