RSpec.configure do |config|
  config.before(:each, type: :view) do
    view.extend FontAwesome::Rails::IconHelper
  end
  
  config.before(:each, type: :helper) do
    helper.extend FontAwesome::Rails::IconHelper
  end
end
