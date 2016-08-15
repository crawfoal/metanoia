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

  def employed_at?(*args)
    false
  end
end
