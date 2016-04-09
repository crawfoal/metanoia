require 'rails_helper'

RSpec.describe Gym, type: :model do
  it { should have_many(:sections).dependent(:destroy) }
end
