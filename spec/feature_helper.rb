require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

require_relative 'features/support/page_objects/base.rb'

Dir[Rails.root.join('spec/features/support/**/*.rb')].each { |f| require f }
