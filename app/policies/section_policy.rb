class SectionPolicy < GymPolicy
  def reset?
    user.employed_at? record.gym, with_role: 'setter'
  end
end
