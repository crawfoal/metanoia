require 'rails_helper'

RSpec.describe EmploymentPolicy do
  let(:gym) { create :gym }
  let(:employment) { create :employment, gym: gym }

  subject { EmploymentPolicy.new(user, employment) }

  context 'for a manager' do
    let(:user) { create :manager, employed_at: gym }

    it { should permit_new_and_create_actions }
    it { should permit_action :index }
  end

  context 'for a non-manager employee' do
    let(:user) { create :setter, employed_at: gym }

    it { should forbid_new_and_create_actions }
    it { should permit_action :index }
  end

  context 'for an athlete' do
    let(:user) { create :athlete }

    it { should forbid_new_and_create_actions }
    it { should forbid_action :index }
  end

  context 'for a user who is a manager, at another gym' do
    let(:user) { create :manager, employed_at: create(:gym) }

    it { should forbid_new_and_create_actions }
    it { should forbid_action :index }
  end
end
