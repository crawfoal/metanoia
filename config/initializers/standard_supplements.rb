require "#{Rails.root}/lib/hash_supplement"
require "#{Rails.root}/lib/active_record_supplement"

Hash.include HashSupplement
ActiveRecord::Base.include ActiveRecordSupplement
