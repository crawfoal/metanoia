class Visitor
  def is_admin?
    false
  end

  def email
    ''
  end

  def current_role
    ''
  end

  def employed_at?(*_args)
    false
  end

  def athlete_story
    nil
  end
end
