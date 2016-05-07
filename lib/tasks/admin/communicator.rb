require_relative '../communicator'

module Tasks
  module Admin
    class Communicator < Tasks::Communicator
      class << self
        def get_email
          # :nocov:
          print 'Please enter the email to be used: '
          gets.chomp
          # :nocov:
        end

        def display_temporary_password(password)
          # :nocov:
          puts 'Temporary password is...'
          puts "  #{password}"
          # :nocov:
        end
      end
    end
  end
end
