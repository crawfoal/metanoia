require "#{Rails.root}/lib/seedster"

namespace :seed do
  desc 'rollback the last migration, and regenerate the seed data files'
  task rollback: :environment do
    # :nocov:
    Seedster.rollback
    # :nocov:
  end
end
