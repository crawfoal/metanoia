module Tasks
  module Heroku
    class AppCommander
      def initialize(app_name)
        @app_name = app_name
      end

      def run_heroku_reset
        run_command('pg:reset DATABASE_URL')
        run_task('db:setup')
        run_command('restart')
        run_task('db:fill')
      end

      def run_command(cmd)
        exec_shell_command!(cmd)
      end

      def run_task(task)
        exec_shell_command!("run rake #{task}")
      end

      private

      def exec_shell_command!(cmd)
        if exec_shell_command(cmd)
          true
        else
          raise "The command `#{cmd}` failed!"
        end
      end

      def exec_shell_command(cmd)
        Bundler.with_clean_env do
          system("heroku #{cmd} --app #{@app_name}")
        end
      end
    end
  end
end
