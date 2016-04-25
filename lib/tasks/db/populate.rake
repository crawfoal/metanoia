namespace :db do
  desc "Fills database with sample data"
  task :populate => [:protected, :environment] do
    Dir[Rails.root.join('db/sample_data/**/*.rb')].each { |f| require f }
    if ENV['HEROKU_APP_NAME']
      unless system('heroku pg:reset ENV["DATABASE_URL"]')
        raise 'heroku pg:reset failed... aborting'
      end
      Rake::Task['db:schema:load'].invoke
      Rake::Task['db:seed'].invoke
    else
      Rake::Task['db:reset'].invoke
    end
    Tasks::DB::Populate.fill_database
  end
end


module Tasks
  module DB
    module Populate
      class << self
        def create_gyms_sections_climbs
          FactoryGirl.create(:wild_walls, climb_factory: :boulder)
          FactoryGirl.create(:boulders_climbing_gym, climb_factory: :boulder)
          FactoryGirl.create(:movement_boulder, climb_factory: :route)
          FactoryGirl.create(:the_spot, climb_factory: :boulder)
          FactoryGirl.create(:sample_gym)
        end

        def create_users
          FactoryGirl.create_list(:admin, 3)
          FactoryGirl.create_list(:user, 3)
        end

        def fill_database
          create_gyms_sections_climbs
          create_users
        end
      end
    end
  end
end
