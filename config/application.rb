require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Metanoia
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Customize the console
    console do
      # Use `ap` method to print pretty, well formated output (as opposed to `puts`)
      require 'ap'

      # Use `pry` instead of `irb` for the Rails console
      require 'pry'
      config.console = Pry
    end
  end
end
