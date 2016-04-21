require_relative 'communicator'

namespace :admin do
  desc 'Create a new user and assign them the role of admin'
  task create: :environment do
    email = Tasks::Admin::Communicator.get_email
    password = Faker::Internet.password
    user = User.create!(
      email: email,
      password: password,
      password_confirmation: password
    )
    user.add_role :admin
    Tasks::Admin::Communicator.display_temporary_password(password)
  end
end
