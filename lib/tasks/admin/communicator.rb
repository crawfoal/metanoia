module Tasks
  module Admin
    class Communicator
      class << self
        def get_email
          print 'Please enter the email to be used: '
          gets.chomp
        end

        def display_temporary_password(password)
          puts 'Temporary password is...'
          puts "  #{password}"
        end

        def print(string)
          STDOUT.print string
        end

        def puts(string)
          STDOUT.puts string
        end

        def gets
          STDIN.gets
        end
      end
    end
  end
end
