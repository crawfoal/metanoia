class ClimbLogger
  def initialize(climb_log_params, user)
    @climb_log_params = climb_log_params
    @athlete_story = user.athlete_story
  end

  def log
    climb_log = ClimbLog.new(@climb_log_params)
    climb_log.athlete_story = @athlete_story

    climb_log.save &&
      @athlete_story.memberships.find_or_create_by(gym: gym) &&
      self
  end

  private

  def gym
    @gym ||= Climb.find(@climb_log_params[:climb_id]).gym
  end
end
