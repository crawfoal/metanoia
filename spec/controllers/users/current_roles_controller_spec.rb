require 'rails_helper'

RSpec.describe Users::CurrentRolesController, type: :controller do
  it { should route(:patch, '/users/current_role').to(action: :update) }
end
