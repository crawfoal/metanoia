require_relative '../communicator'

module Tasks
  module Admin
    class Communicator < Tasks::Communicator
      class << self
        def get_email
          print 'Please enter the email to be used: '
          gets.chomp
        end

        def display_temporary_password(password)
          puts 'Temporary password is...'
          puts "  #{password}"
        end
      end
    end
  end
end
