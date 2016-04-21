require 'rails_helper'

RSpec.describe ProfileController, type: :controller do
  it { should route(:get, '/profile').to(action: :show) }
end
