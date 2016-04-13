require 'rails_helper'

RSpec.describe Gym, type: :model do
  it { should have_many(:sections).dependent(:destroy) }
  it { should extract_value_from(:name, collections: :sections) }

  it "is invalid if `#value` is blank" do
    expect(Gym.new).to_not be_valid
  end
end
