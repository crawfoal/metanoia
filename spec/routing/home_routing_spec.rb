require 'rails_helper'

RSpec.describe HomeController do
  describe "routing" do
    it do
      expect(get: "/").to route_to(controller: 'home', action: 'show')
    end
  end
end
