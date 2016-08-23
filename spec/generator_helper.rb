require 'rails_helper'
require 'ammeter/init'

Dir[Rails.root.join('lib/generators/**/*.rb')].each { |f| require f }

module GeneratorHelper
  def default_destination
    '../../../tmp'
  end
end

RSpec.configure do |config|
  config.include GeneratorHelper, type: :generator
end

# These specs use the [ammeter](https://github.com/alexrothenberg/ammeter) gem.
