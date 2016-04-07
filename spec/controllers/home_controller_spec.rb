require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  it { should route(:get, '/').to(action: :show) }
end
