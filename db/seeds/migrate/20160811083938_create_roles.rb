class CreateRoles
  def up
    Role.create! name: 'admin'
    Role.create! name: 'athlete'
    Role.create! name: 'manager'
    Role.create! name: 'setter'
  end

  def down
    Role.destroy_all(name: %w(admin athlete manager setter))
  end
end
