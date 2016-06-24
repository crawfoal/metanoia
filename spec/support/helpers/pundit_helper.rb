RSpec.configure do |config|
  config.before(:each, type: :view) do
    controller.singleton_class.include Pundit
    allow(controller).to receive(:current_user) do
      raise "Error: the method `current_user` wasn't stubbed! You need to "\
            "stub it out to return the appropriate user for the example and "\
            "context."
    end
  end
end
