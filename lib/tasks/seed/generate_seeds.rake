require "#{Rails.root}/lib/seedster"

namespace :seed do
  desc 'generates the yaml seed files based on the current state of the '\
       'seeded tables in the database'
  task generate_seeds: :environment do
    Seedster.generate_seeds
  end
end
