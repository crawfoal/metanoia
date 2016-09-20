require "#{Rails.root}/lib/seedster"

Seedster.configure do |config|
  config.tables = [:grade_systems, :grades, :buckets, :roles]
end

ApplicationRecord.class_eval do
  include Seedster::ActiveRecordHelpers
end
