class RemoveSamCreateAmanda
  def up
    User.find_by_email('sam@example.com').destroy
    User.create!(
      email: 'amanda@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  def down
    User.find_by_email('amanda@example.com').destroy
    User.create!(
      email: 'sam@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end
end
