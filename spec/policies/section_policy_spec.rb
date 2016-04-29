require 'rails_helper'

RSpec.describe SectionPolicy do
  it 'should defer all decisions to GymPolicy' do
    expect(SectionPolicy.superclass).to eq GymPolicy
    expect(SectionPolicy.instance_methods(false)).to be_empty
  end
end
