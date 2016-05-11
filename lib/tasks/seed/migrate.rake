require_relative 'migrator'

namespace :seed do
  desc 'run outstanding migrations, and regenerate the seed data files'
  task migrate: :environment do
    Migrator.new.run_outstanding_migrations
  end
end
