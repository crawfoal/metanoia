class SectionsController < ApplicationController
  def new
    @gym_form = GymForm.new
  end
end
