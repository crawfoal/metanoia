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
          user = FactoryGirl.create(:admin)
          user.add_role :athlete

          FactoryGirl.create_list(:admin, 3)
          FactoryGirl.create_list(:athlete, 3)
        end

        def fill_database
          Dir[Rails.root.join('db/sample_data/**/*.rb')].each { |f| require f }
          create_gyms_sections_climbs
          create_users
        end
      end
    end
  end
end
