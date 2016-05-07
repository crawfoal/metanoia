module LogClimbsHelper
  def log_all_climbs(gym, athlete)
    gym.sections.each do |section|
      section.climbs.each do |climb|
        ClimbLogger.new({climb_id: climb.id}, athlete).log
      end
    end
  end
end

RSpec.configure do |config|
  config.include LogClimbsHelper
end
