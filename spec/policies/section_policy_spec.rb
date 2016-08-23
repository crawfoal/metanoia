require 'rails_helper'

RSpec.describe SectionPolicy do
  let(:climb) { create :climb }

  subject { SectionPolicy.new(user, climb.section) }

  it 'should inherit from GymPolicy' do
    expect(SectionPolicy.superclass).to eq GymPolicy
  end

  context 'for a visitor' do
    let(:user) { Visitor.new }

    it { should forbid_action :reset }
  end

  context 'for a setter who works at the gym' do
    let(:user) { create :setter, employed_at: climb.gym }

    it { should permit_action :reset }
  end

  context 'for a setter who does not work at the gym' do
    let(:user) { create :setter }
    
    it { should forbid_action :reset }
  end
end
