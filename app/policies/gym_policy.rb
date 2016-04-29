class GymPolicy < ApplicationPolicy
  def create?
    user.current_role == 'admin'
  end

  def update?
    user.current_role == 'admin'
  end
end
