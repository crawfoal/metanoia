require 'rails_helper'

RSpec.describe Athletes::ClimbLogsController, type: :controller do
  it { should route(:post, 'athletes/climb_logs').to(action: :create) }
end
