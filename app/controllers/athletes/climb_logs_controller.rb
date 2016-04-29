class Athletes::ClimbLogsController < ApplicationController
  def create
    climb_log = ClimbLog.new(climb_log_params)
    climb_log.athlete_story = current_user.athlete_story
    if climb_log.save
      flash[:notice] = 'Climb successfully logged!'
    else
      flash[:alert] = 'Failed to log climb!'
    end
  end

  private

  def climb_log_params
    params.require(:climb_log).permit(:climb_id)
  end
end
