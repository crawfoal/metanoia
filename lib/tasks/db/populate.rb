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
          user = FactoryGirl.create(:manager, employed_at: {name: 'Wild Walls'})
          user.add_role :setter
          ww = Gym.find_by_name('Wild Walls')
          ww.employments.create(role_story: user.setter_story)

          FactoryGirl.create_list(:admin, 3)
          FactoryGirl.create_list(:athlete, 3)
          FactoryGirl.create_list(:setter, 3, employed_at: {name: 'Wild Walls'})
          FactoryGirl.create_list(:manager, 3, employed_at: {name: 'Wild Walls'})
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
