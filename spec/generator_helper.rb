require 'rails_helper'
require 'ammeter/init'

module GeneratorHelper
  def default_destination
    '../../../tmp'
  end
end

RSpec.configure do |config|
  config.include GeneratorHelper, type: :generator
end
