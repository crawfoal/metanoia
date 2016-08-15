require 'rails_helper'

RSpec.describe ClimbPolicy do
  let(:climb) { create :climb }
  subject { ClimbPolicy.new(user, climb) }

  context 'for a visitor' do
    let(:user) { Visitor.new }
    it { should forbid_new_and_create_actions }
  end

  context 'for an athlete' do
    let(:user) { create :athlete }
    it { should forbid_new_and_create_actions }
  end

  context 'for a setter and gym they are employed at' do
    let(:user) { create :setter, employed_at: climb.gym }
    subject { ClimbPolicy.new(user, climb) }
    it { should permit_new_and_create_actions }
  end

  context 'for a setter and a gym they are not employed at' do
    let(:user) { create :setter }
    it { should forbid_new_and_create_actions }
  end

  context 'for an admin' do
    let(:user) { create :admin }
    it { should forbid_new_and_create_actions }
  end
end
