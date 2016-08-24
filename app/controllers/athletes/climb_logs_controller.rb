class Athletes::ClimbLogsController < ApplicationController
  before_action :verify_current_user_is_athlete

  def create
    if ClimbLogger.new(climb_log_params, current_user).log
      flash.now[:notice] = 'Climb successfully logged!'
    else
      flash.now[:alert] = 'Failed to log climb!'
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
      respond_to do |format|
        format.html do
          flash[:alert] = 'Sorry, only athletes have a climb log.'
          redirect_to :back
        end

        format.js do
          flash.now[:alert] = 'Sorry, only athletes have a climb log.'
          render
        end
      end
    end
  end
end
