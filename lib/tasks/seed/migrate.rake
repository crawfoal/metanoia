require "#{Rails.root}/lib/seedster"

namespace :seed do
  desc 'run outstanding migrations, and regenerate the seed data files'
  task migrate: :environment do
    # :nocov:
    Seedster.migrate
    # :nocov:
  end
end
