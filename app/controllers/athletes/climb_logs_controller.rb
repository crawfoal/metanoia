class Athletes::ClimbLogsController < ApplicationController
  def create
    if ClimbLogger.new(climb_log_params, current_user).log
      flash[:notice] = 'Climb successfully logged!'
    else
      flash[:alert] = 'Failed to log climb!'
    end
  end

  def index
    @climb_logs_tree = ClimbLogsTree.new(current_user.athlete_story)
  end

  private

  def climb_log_params
    params.require(:climb_log).permit(:climb_id)
  end
end
