class GymsController < ApplicationController
  def new
    @gym_form ||= Forms::Gym.new
  end

  def create
    @gym_form = Forms::Gym.new(gym_form_params)
    if @gym_form.save
      redirect_to gyms_path, notice: 'New gym successfully created!'
    else
      render :new
    end
  end

  def index
    @gyms = Gym.all
  end

  private
  
  def gym_form_params
    params.require(:gym).permit(
      :name,
      sections_attributes: [:name]
    )
  end
end
