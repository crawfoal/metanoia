class SectionsController < ApplicationController
  def new
    @gym_form = GymForm.new
  end

  def show
    @section = Section.find(params[:id])
  end
end
