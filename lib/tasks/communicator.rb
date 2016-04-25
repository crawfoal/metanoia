module Tasks
  class Communicator
    class << self
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
