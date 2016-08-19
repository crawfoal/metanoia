class Athletes::ClimbLogsController < ApplicationController
  before_action :verify_current_user_is_athlete

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

  def verify_current_user_is_athlete
    unless current_user.has_role? :athlete
      flash[:alert] = 'Sorry, only athletes have a climb log.'
      redirect_to :back
    end
  end
end
