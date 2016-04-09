require_relative "page_objects/base"
Dir[Rails.root.join('spec/features/support/page_objects/**/*.rb')].each { |f| require f }
