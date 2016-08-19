class ClimbPolicy < ApplicationPolicy
  def create?
    user.employed_at? record.gym, with_role: 'setter'
  end
end
