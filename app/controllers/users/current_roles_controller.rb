class Users::CurrentRolesController < ApplicationController
  def update
    if current_user.has_role? params[:user][:current_role]
      current_user.update(current_role: params[:user][:current_role])
    end
    redirect_to user_root_path
  end
end
