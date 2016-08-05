require 'rails_helper'

RSpec.describe ClimbPolicy do
  subject { ClimbPolicy.new(user, Climb) }

  context 'for a visitor' do
    let(:user) { Visitor.new }
    it { should forbid_new_and_create_actions }
    it { should forbid_edit_and_update_actions }
  end

  context 'for an athlete' do
    let(:user) { create :athlete }
    it { should forbid_new_and_create_actions }
    it { should forbid_edit_and_update_actions }
  end

  context 'for a setter' do
    let(:user) { create :setter }
    it { should permit_new_and_create_actions }
    it { should permit_edit_and_update_actions }
  end

  context 'for an admin' do
    let(:user) { create :admin }
    it { should forbid_new_and_create_actions }
    it { should forbid_edit_and_update_actions }
  end
end
