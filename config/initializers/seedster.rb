require "#{Rails.root}/lib/seedster"

Seedster.configure do |config|
  config.tables = [:grade_systems, :grades, :buckets]
end
