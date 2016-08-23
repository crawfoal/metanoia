require 'rails_helper'

RSpec.describe EmployeeListPolicy do
  let(:employee_list) { create :employee_list }
  
  subject { EmployeeListPolicy.new(user, employee_list) }

  context 'for an employee of the gym' do
    let(:user) { create :manager, employed_at: employee_list.gym }

    it { should permit_action :index }
  end

  context "for someone who isn't an employee at the gym" do
    let(:user) { create :user }

    it { should forbid_action :index }
  end

  context 'for someone who is a manager at another gym' do
    let(:user) { create :user, employed_at: create(:gym) }

    it { should forbid_action :index }
  end
end
