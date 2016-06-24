class ClimbPolicy < ApplicationPolicy
  def create?
    user.current_role == 'setter'
  end

  def update?
    user.current_role == 'setter'
  end
end
