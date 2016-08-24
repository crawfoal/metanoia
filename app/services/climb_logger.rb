class ClimbLogger
  def initialize(climb_log_params, user)
    @climb_log_params = climb_log_params
    @athlete_story = user.athlete_story
  end

  def log
    build_climb_log.save && find_or_create_membership && self
  end

  private

  def build_climb_log
    climb_log = ClimbLog.new(@climb_log_params)
    climb_log.athlete_story = @athlete_story
    climb_log
  end

  def find_or_create_membership
    @athlete_story.memberships.find_or_create_by(gym: gym)
  end

  def gym
    @gym ||= Climb.find(@climb_log_params[:climb_id]).gym
  end
end
