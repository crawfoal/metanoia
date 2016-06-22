class CreateSam
  def up
    User.create!(
      email: 'sam@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  def down
    User.find_by_email('sam@example.com').destroy
  end
end
