class CreateTj
  def up
    User.create!(
      email: 'tj@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  def down
    User.find_by_email('tj@example.com').destroy
  end
end
