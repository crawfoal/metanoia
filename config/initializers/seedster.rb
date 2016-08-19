require "#{Rails.root}/lib/seedster"

Seedster.configure do |config|
  config.tables = [:grade_systems, :grades, :buckets, :roles]
end

# Change to ApplicationRecord in Rails 5.0
class ActiveRecord::Base
  include Seedster::ActiveRecordHelpers
end
