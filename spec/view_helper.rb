require 'rails_helper'

require_relative 'features/support/page_objects/base.rb'
Dir[Rails.root.join('spec/features/support/page_objects/**/*.rb')].each do |f|
  require f
end
