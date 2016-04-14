class GymsController < ApplicationController
  def new
    @gym_form ||= GymForm.new
  end

  def create
    @gym_form = GymForm.new
    @gym_form.attributes = gym_form_params
    if @gym_form.save
      redirect_to gyms_path, notice: 'New gym successfully created!'
    else
      render :new
    end
  end

  def index
    @gyms = Gym.all
  end

  def show
    @gym = Gym.find(params[:id])
  end

  def edit
    @gym_form ||= GymForm.new(Gym.find(params[:id]))
  end

  def update
    @gym_form = GymForm.new(Gym.find(params[:id]))
    @gym_form.attributes = gym_form_params
    if @gym_form.save
      gym_name = @gym_form.name || 'Un-named gym'
      redirect_to gyms_path, notice: "#{gym_name} successfully updated!"
    else
      render :edit
    end
  end

  private

  def gym_form_params
    params.require(:gym).permit(
      :name,
      sections_attributes: [:id, :name, :_destroy]
    )
  end
end
