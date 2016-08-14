module CapybaraHelper
  def reload_page
    visit current_path
  end
end

RSpec.configure do |config|
  config.include CapybaraHelper
end
