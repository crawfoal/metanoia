require "#{Rails.root}/lib/hash_supplement"
require "#{Rails.root}/lib/active_record_supplement"
require "#{Rails.root}/lib/object_supplement"

Object.include ObjectSupplement
Hash.include HashSupplement
ActiveRecord::Base.include ActiveRecordSupplement
